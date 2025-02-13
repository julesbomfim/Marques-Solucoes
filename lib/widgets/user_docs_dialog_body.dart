import 'package:file_picker/file_picker.dart';
import 'package:flutter_web/helper/select_files.dart';
import 'package:flutter_web/utils/conformation_dialog.dart';
import 'dart:html' as html;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/controllers/user-controller/user_controller.dart';
import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/utils/loandig.dart';

class UserDocsDialogBody extends StatefulWidget {
  final Usua user;

  const UserDocsDialogBody({super.key, required this.user});

  @override
  State<UserDocsDialogBody> createState() => _UserDocsDialogBodyState();
}

class _UserDocsDialogBodyState extends State<UserDocsDialogBody> {
////// download
  Future<void> downloadFile(String userId, String fileName) async {
    try {
      // Get the download URL for the file
      String downloadURL = await FirebaseStorage.instance
          .ref('arquivos/$userId/$fileName')
          .getDownloadURL();

      // Create an anchor element
      final html.AnchorElement anchor = html.AnchorElement(href: downloadURL)
        ..target = 'webbrowser_download';

      // Trigger a click on the anchor element
      html.document.body!.children.add(anchor);
      anchor.click();

      // Remove the anchor element
      html.document.body!.children.removeLast();

      // Optional: Show a notification or UI feedback for successful download
      print('File $fileName downloaded successfully for user $userId!');
    } catch (e) {
      // Handle errors, such as file not found or permission issues
      print('Error downloading file: $e');
    }
  }

  List<PlatformFile> selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      width: 400,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Documentos anexados',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        if (widget.user.docs.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: widget.user.docs
                    .map(
                      (docName) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                docName,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            IconButton(
                                onPressed: () {
                                  downloadFile(widget.user.id, docName);
                                },
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                )),
                            IconButton(
                              onPressed: () async {
                                final userController = UserController();

                                final confirmationResponse =
                                    await confirmationDialog(
                                  context: context,
                                  msg: 'Deseja excluir o documento: $docName',
                                );

                                if (confirmationResponse == null ||
                                    !confirmationResponse) {
                                  return;
                                }

                                loadingDialog(
                                    context, 'Excluindo documento...');

                                final response =
                                    await userController.deleteUserDoc(
                                  user: widget.user,
                                  fileName: docName,
                                );

                                Navigator.pop(context);

                                final snackBar = SnackBar(
                                  content: Text(response['message']),
                                  backgroundColor: response['success']
                                      ? Colors.green
                                      : Colors.red,
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red, // Change the color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () async {
              final files = await selectPlatformFiles();

              if (files == null || files.isEmpty) {
                return;
              }

              selectedFiles.addAll(files);

              setState(() {});
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => const Color(0xFF0d1b2a)),
            ),
            child: const Text(
              'Selecionar arquivos',
              style: TextStyle(color: Colors.white),
            )),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: selectedFiles.isEmpty
                ? null
                : () async {
                    String loadingMessageAux =
                        selectedFiles.length == 1 ? 'documento' : 'documentos';

                    loadingDialog(context, 'Inserindo $loadingMessageAux...');

                    final userController = UserController();

                    final response = await userController.insertUserDocs(
                        user: widget.user, files: selectedFiles);

                    Navigator.pop(context);

                    final snackBar = SnackBar(
                      content: Text(response['message']),
                      backgroundColor:
                          response['success'] ? Colors.green : Colors.red,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    selectedFiles.clear();

                    setState(() {});
                  },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => const Color(0xFF0d1b2a)),
            ),
            child:
                const Text('Atualizar lista', style: TextStyle(color: Colors.white))),
        const SizedBox(height: 20),
        Text(
          'Arquivos selecionados: ${selectedFiles.map((file) => file.name).join(', ')}',
          style: const TextStyle(fontSize: 16, color: Colors.white),
          textAlign: TextAlign.start,
        ),
      ]),
    );
  }
}
