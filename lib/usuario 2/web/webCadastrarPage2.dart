import 'dart:io';

import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:flutter_web/usuario%202/web/authetic2.dart';
import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/router.dart';
import 'package:flutter_web/usuario%202/web/uploadFileWeb2.dart';
import 'package:flutter_web/utils/alert.dart';
import 'package:flutter_web/utils/loandig.dart';
import 'package:flutter_web/utils/masks.dart';
import 'package:intl/intl.dart';

import 'package:path/path.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class webCadastrarPage2 extends StatefulWidget {
  const webCadastrarPage2({super.key});

  @override
  State<webCadastrarPage2> createState() => _webCadastrarPage2State();
}

class _webCadastrarPage2State extends State<webCadastrarPage2> {
  TextEditingController nomeCliente = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController pre = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController anotacoes = TextEditingController();
  AuthService2 authService2 = AuthService2();

  final statusValue = ValueNotifier('');
  final dropCategoria = ['Finalizado', 'Pendente'];

  String _radioValue = '';

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final fileName = basename(pickedFile!.path!);

    final file = File(pickedFile!.path!);
    final destination = ('file/$fileName');

    final ref = FirebaseStorage.instance.ref(destination);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download link: $urlDownload ');

    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 50,
          );
        }
      });

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
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: const EdgeInsets.all(40),
                          child: const Text(
                            "Cadastro de Clientes",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF1b263b),
                            ),
                          ),
                        ),
                        Container(
                          height: 660,
                          width: 650,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF1b263b).withOpacity(0.5),
                              border: Border.all(
                                color: const Color(0xFF1b263b),
                              )),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10.0),
                                    child: SizedBox(
                                      height: 60,
                                      width: 350,
                                      child: TextFormField(
                                          controller: nomeCliente,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF1b263b),
                                                ),
                                              ),
                                              border: UnderlineInputBorder(),
                                              labelText: 'Nome',
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10))),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10.0),
                                    child: SizedBox(
                                      height: 60,
                                      width: 200,
                                      child: TextFormField(
                                        controller: cpf,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [cpfMask],
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.white),
                                        decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF0d1b2a),
                                              ),
                                            ),
                                            border: UnderlineInputBorder(),
                                            labelText: 'CPF',
                                            labelStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Campo requerido!';
                                          }

                                          if (text.length != 14) {
                                            return 'CPF incompleto!';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10.0),
                                        child: SizedBox(
                                          height: 60,
                                          width: 250,
                                          child: TextFormField(
                                              controller: email,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFF0d1b2a),
                                                    ),
                                                  ),
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: 'Email',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10))),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10.0),
                                        child: SizedBox(
                                          height: 60,
                                          width: 140,
                                          child: TextFormField(
                                              controller: pre,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                ThousandsFormatter(
                                                    allowFraction: true,
                                                    formatter: NumberFormat(
                                                        '##' '.##'))
                                              ],
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFF0d1b2a),
                                                    ),
                                                  ),
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: 'Preço',
                                                  prefix: Text(
                                                    'R\$ ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10))),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10.0),
                                        child: SizedBox(
                                          height: 60,
                                          width: 140,
                                          child: TextFormField(
                                            controller: data,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                            decoration: const InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF1b263b),
                                                  ),
                                                ),
                                                border: UnderlineInputBorder(),
                                                labelText: 'Data',
                                                labelStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                            onTap: () async {
                                              DateTime? pickeddate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2100));

                                              if (pickeddate != null) {
                                                setState(() {
                                                  data.text =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(pickeddate);
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ]),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10.0),
                                      child: SizedBox(
                                        width: 560,
                                        child: TextField(
                                          maxLines: 5,
                                          controller: anotacoes,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                              fillColor: Color.fromARGB(
                                                  255, 21, 30, 46),
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF1b263b),
                                                ),
                                              ),
                                              border: UnderlineInputBorder(),
                                              labelText: 'Anotações',
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(children: [
                                  Row(children: [
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: ListTile(
                                              title: const Text("PROJETO BB",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              leading: Radio(
                                                  value: 'PROJETO BB',
                                                  activeColor:
                                                      const Color(0xFF1b263b),
                                                  groupValue: _radioValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _radioValue =
                                                          value.toString();
                                                    });
                                                  }),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: ListTile(
                                              title: const Text("CCIR e ITR",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              leading: Radio(
                                                  value: 'CCIR e ITR',
                                                  activeColor:
                                                      const Color(0xFF1b263b),
                                                  groupValue: _radioValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _radioValue =
                                                          value.toString();
                                                    });
                                                  }),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: ListTile(
                                              title: const Text("GEO",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              leading: Radio(
                                                  value: 'GEO',
                                                  groupValue: _radioValue,
                                                  activeColor:
                                                      const Color(0xFF1b263b),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _radioValue =
                                                          value.toString();
                                                    });
                                                  }),
                                            ),
                                          ),
                                          Container(
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              child: ListTile(
                                                title: const Text("CAR/CEFIR",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                leading: Radio(
                                                    value: 'CAR/CEFIR',
                                                    groupValue: _radioValue,
                                                    activeColor:
                                                        const Color(0xFF1b263b),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioValue =
                                                            value.toString();
                                                      });
                                                    }),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(60),
                                        child: ValueListenableBuilder(
                                            valueListenable: statusValue,
                                            builder: (BuildContext context,
                                                String value, _) {
                                              return SizedBox(
                                                child: DropdownButtonFormField(
                                                  dropdownColor:
                                                      const Color(0xFF1b263b),
                                                  focusColor: const Color(0xFF1b263b),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  isExpanded: true,
                                                  hint: const Text(
                                                    'Selecione a opção',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        const Color(0xFF1b263b),
                                                    labelText: 'Status',
                                                    labelStyle: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      borderSide: const BorderSide(
                                                        color:
                                                            Color(0xFF1b263b),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF1b263b),
                                                      ), //<-- SEE HERE
                                                    ),
                                                  ),
                                                  value: (value.isEmpty)
                                                      ? null
                                                      : value,
                                                  onChanged: (escolha) =>
                                                      statusValue.value =
                                                          escolha.toString(),
                                                  items: dropCategoria
                                                      .map(
                                                        (op) =>
                                                            DropdownMenuItem(
                                                          value: op,
                                                          child: Text(op),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  ])
                                ]),
                              ]),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 25.0),
                                  child: SizedBox(
                                    height: 40,
                                    width: 200,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          final user = Usua(
                                              nome: nomeCliente.text,
                                              cpf: cpf.text,
                                              email: email.text,
                                              preco: num.parse(pre.text),
                                              servico: _radioValue.toString(),
                                              status: statusValue.value,
                                              data: data.text,
                                              anotacoes: anotacoes.text);

                                          if (!CPFValidator.isValid(cpf.text)) {
                                            alertDialog(
                                                context, 'CPF invalido!');
                                            return;
                                          }
                                          loadingDialog(
                                              context, 'Carregando...');

                                          await authService2.addUser(user);

                                          Navigator.pop(context);
                                          alertDialog(
                                            context,
                                            'Cliente cadastrado com sucesso!',
                                          );
                                          setState(() {
                                            nomeCliente.text = '';
                                            email.text = '';
                                            cpf.text = '';
                                            pre.text = '';
                                            data.text = '';
                                            anotacoes.text = '';
                                          });

                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => upload2(
                                                      user: user,
                                                    )),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) =>
                                                      const Color(0xFF0d1b2a)),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add,
                                                color: Colors.white),
                                            Padding(
                                              padding: EdgeInsets.all(7),
                                              child: Text('Cadastrar',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        )),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ]))),
        ));
  }
}
