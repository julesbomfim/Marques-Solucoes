import 'dart:io';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/Page/cadastrarPage/uploadFileMobile.dart';
import 'package:flutter_web/auth/authentic.dart';
import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/homePage.dart';
import 'package:flutter_web/router.dart';
import 'package:flutter_web/utils/alert.dart';
import 'package:flutter_web/utils/loandig.dart';
import 'package:flutter_web/utils/masks.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mobileCadastrarPage extends StatefulWidget {
  const mobileCadastrarPage({super.key});

  @override
  State<mobileCadastrarPage> createState() => _mobileCadastrarPageState();
}

class _mobileCadastrarPageState extends State<mobileCadastrarPage> {
  TextEditingController nomeCliente = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController pre = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController anotacoes = TextEditingController();
  AuthService authService = AuthService();

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

  AuthService authController = AuthService();
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
                accountEmail: Text('Agência'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.yellow),
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
                  RouterManager.router.navigateTo(context, '/visualPage');
                },
              ),
              ListTile(
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  'Cadastrar Clientes',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  RouterManager.router.navigateTo(context, '/cadastrarPage');
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
                  await authController.signOut(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const homePage()));
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
                          height: 900,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF1b263b).withOpacity(0.5),
                              border: Border.all(
                                color: const Color(0xFF1b263b),
                              )),
                          child: Column(
                            children: [
                              Column(
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
                                      width: 350,
                                      child: TextFormField(
                                          controller: email,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF0d1b2a),
                                                ),
                                              ),
                                              border: UnderlineInputBorder(),
                                              labelText: 'Email',
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10))),
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
                                          width: 170,
                                          child: TextFormField(
                                            controller: cpf,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [cpfMask],
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
                                                border: UnderlineInputBorder(),
                                                labelText: 'CPF',
                                                labelStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
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
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10.0),
                                        child: SizedBox(
                                          height: 60,
                                          width: 130,
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
                                    ]),
                                Column(
                                  children: [
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
                                              focusedBorder: OutlineInputBorder(
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
                                                    initialDate: DateTime.now(),
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
                                                horizontal: 5),
                                            child: ListTile(
                                              title: const Text("PROJETO BB",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10)),
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
                                                horizontal: 5),
                                            child: ListTile(
                                              title: const Text("CCIR e ITR",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10)),
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
                                                horizontal: 5),
                                            child: ListTile(
                                              title: const Text("GEO",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10)),
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
                                                  horizontal: 5),
                                              child: ListTile(
                                                title: const Text("CAR/CEFIR",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
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
                                        padding: const EdgeInsets.all(6),
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

                                          await authService.addUser(user);

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
                                                builder: (context) =>
                                                    uploadMobile(
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
