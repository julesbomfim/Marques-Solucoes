import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/router.dart';
import 'package:flutter_web/usuario%202/web/authetic2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class uploadMobile2 extends StatefulWidget {
  //final Usua user;
  const uploadMobile2({super.key, required this.user});
  final Usua user;

  @override
  State<uploadMobile2> createState() => _uploadMobile2State();
}

class _uploadMobile2State extends State<uploadMobile2> {
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
          title: Image.asset(
            'assets/imagem5.png',
            fit: BoxFit.contain,
            width: 80,
            height: 80,
          ),
          toolbarHeight: 62,
          elevation: 60,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 233, 232, 232),
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFF1b263b),
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text('Marques Soluções e Consultoria'),
                accountEmail: Text('Pessoal'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.green),
                ),
                decoration: BoxDecoration(color: Color(0xFF1b263b)),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  'Página Inicial',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Adicione a lógica para navegar para a página inicial
                  RouterManager.router
                      .navigateTo(context, '/visualPageMobile2');
                },
              ),
              ListTile(
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  'Cadastrar Clientes',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  RouterManager.router
                      .navigateTo(context, '/cadastrarPageMobile2');
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_rounded,
                    color: Colors.white),
                title: const Text(
                  'Usuário',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  RouterManager.router.navigateTo(context, '/usuario');
                },
              ),
              // Adicione mais itens conforme necessário
              ListTile(
                leading: const Icon(Icons.info, color: Colors.white),
                title: const Text(
                  'Contato',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
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
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                        backgroundImage:
                                            AssetImage('assets/imagem6.png'),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        'Jules Bomfim Mangueira',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Engenheiro da Computação',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '     (74) 9 9197-3801',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        ' julessbomfim@gmail.com',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ])))
                          ]))))));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_sharp, color: Colors.white),
                title: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  await authController2.signOut(context);
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => const homePage()));
                },
              ),
            ],
          ),
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
                            margin: const EdgeInsets.all(80),
                            child: const Text(
                              "Adicionar documento do cliente",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFF1b263b),
                              ),
                            ),
                          ),
                          Container(
                            height: 500,
                            width: 300,
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
                                    'Selecionar documentos',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Quantidade: ${files == null ? 0 : files?.length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
                                              fontSize: 16,
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
                                      RouterManager.router.navigateTo(
                                          context, '/visualPageMobile2');
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
