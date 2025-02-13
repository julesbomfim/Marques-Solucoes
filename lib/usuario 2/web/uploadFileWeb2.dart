import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/router.dart';
import 'package:flutter_web/usuario%202/web/authetic2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class upload2 extends StatefulWidget {
  //final Usua user;
  const upload2({super.key, required this.user});
  final Usua user;

  @override
  State<upload2> createState() => _upload2State();
}

class _upload2State extends State<upload2> {
  List<Map<String, dynamic>>? files;

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  bool isUploadingFiles = false;

  Future<List<Map<String, dynamic>>?>? selectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: true);

    if (result != null) {
      return result.files
          .map((file) => {
                'name': file.name,
                'bytes': file.bytes,
              })
          .toList();
    }

    return null;
  }

  Future uploadFile(Map<String, dynamic> fileData) async {
    final String fileName = fileData['name'];
    final Uint8List bytes = fileData['bytes'];

    await FirebaseStorage.instance
        .ref('arquivos/${widget.user.id}/$fileName')
        .putData(bytes);
  }

  Future saveUserFilesName() async {
    final docsName = files!.map((file) => file['name']).toList();

    await FirebaseFirestore.instance
        .collection('Clientes2')
        .doc(widget.user.id)
        .update({'docs': docsName});
  }

  late SharedPreferences _prefs;
  String _lastVisitedPage = '/';

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _lastVisitedPage = _prefs.getString('lastVisitedPage') ?? '/';
    setState(() {}); // Rebuild the widget to reflect the initial state.
  }

  AuthService2 authController2 = AuthService2();
  @override
  Widget build(BuildContext context) {
    //   final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/imagem5.png',
            fit: BoxFit.contain,
            width: 100,
            height: 100,
          ),
          toolbarHeight: 72,
          elevation: 60,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 233, 232, 232),
              ),
              height: 80,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.green),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Pessoal',
                          style:
                              TextStyle(color: Color(0xFF1b263b), fontSize: 20),
                        ),
                        const SizedBox(
                          width: 540,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                color: Color(0xFF1b263b), fontSize: 20),
                          ),
                          onPressed: () {
                            RouterManager.router
                                .navigateTo(context, '/visualPage2');
                          },
                          child: const Text(
                            'Página Inicial',
                            style: TextStyle(
                                color: Color(0xFF1b263b), fontSize: 17),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                color: Color(0xFF1b263b), fontSize: 20),
                          ),
                          onPressed: () {
                            RouterManager.router
                                .navigateTo(context, '/cadastrarPage2');
                          },
                          child: const Text(
                            'Cadastrar Clientes',
                            style: TextStyle(
                                color: Color(0xFF1b263b), fontSize: 17),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                color: Color(0xFF1b263b), fontSize: 20),
                          ),
                          onPressed: () {
                            RouterManager.router
                                .navigateTo(context, '/usuario');
                          },
                          child: const Text(
                            'Usuário',
                            style: TextStyle(
                                color: Color(0xFF1b263b), fontSize: 17),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                color: Color(0xFF1b263b), fontSize: 20),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                    insetPadding: const EdgeInsets.all(6),
                                    backgroundColor: const Color(0xFF1b263b),
                                    content: SingleChildScrollView(
                                        child: Container(
                                            child: Column(children: [
                                      Container(
                                          height: 400,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xFF1b263b)
                                                  .withOpacity(0.5),
                                              border: Border.all(
                                                color: const Color(0xFF1b263b),
                                              )),
                                          child: const Center(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                CircleAvatar(
                                                  radius: 80,
                                                  backgroundImage: AssetImage(
                                                      'assets/imagem6.png'),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                Text(
                                                  'Jules Bomfim Mangueira',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Engenheiro da Computação',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  '     (74) 9 9197-3801',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  ' julessbomfim@gmail.com',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ])))
                                    ]))))));
                          },
                          child: const Text(
                            'Contato',
                            style: TextStyle(
                                color: Color(0xFF1b263b), fontSize: 17),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xFF1b263b)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20),
                            ),
                            onPressed: () async {
                              await authController2.signOut(context);
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) => const homePage()));
                            },
                            child: const Text(
                              'Sair',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 17),
                            ),
                          ),
                        )
                      ],
                    )
                  ])),
        ),
        body: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 2400),
                child: Container(
                    width: 2000,
                    height: 2000,
                    decoration: const BoxDecoration(color: Color(0xFFe0e1dd)),
                    child: ListView(children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(40),
                            child: const Text(
                              "Adicionar documento do cliente",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xFF1b263b),
                              ),
                            ),
                          ),
                          Container(
                            height: 550,
                            width: 650,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF1b263b).withOpacity(0.5),
                                border: Border.all(
                                  color: const Color(0xFF1b263b),
                                )),
                            child: Column(
                              children: [
                                if (!isUploadingFiles)
                                  const SizedBox(height: 150),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => const Color(0xFF0d1b2a)),
                                  ),
                                  onPressed: () async {
                                    files = await selectFile();

                                    setState(() {});
                                  },
                                  child: const Text(
                                    'Selecionar arquivos',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Quantidade: ${files == null ? 0 : files?.length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                if (files != null)
                                  Column(
                                    children: files!
                                        .map(
                                          (file) => Text(
                                            file['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                const SizedBox(height: 50),
                                ElevatedButton(
                                  onPressed: files != null
                                      ? () async {
                                          setState(() {
                                            isUploadingFiles = true;
                                          });

                                          await Future.wait(
                                              files!.map((fileData) async {
                                            await uploadFile(fileData);
                                          }));

                                          await saveUserFilesName();

                                          files = null;

                                          setState(() {
                                            isUploadingFiles = false;
                                          });
                                        }
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => const Color(0xFF0d1b2a)),
                                  ),
                                  child: isUploadingFiles
                                      ? const FittedBox(
                                          fit: BoxFit.cover,
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text(
                                          "Anexar arquivos",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => const Color(0xFF0d1b2a)),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      RouterManager.router
                                          .navigateTo(context, '/visualPage2');
                                    },
                                    child: const Text(
                                      "Concluir cadastro",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ])))));
  }
}
