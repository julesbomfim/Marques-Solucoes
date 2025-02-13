import 'package:flutter/material.dart';
import 'package:flutter_web/auth/authentic.dart';

import 'package:flutter_web/router.dart';

import 'package:flutter_web/visualPage.dart';

import 'package:shared_preferences/shared_preferences.dart';

class mobileUsuario extends StatefulWidget {
  const mobileUsuario({super.key});

  @override
  State<mobileUsuario> createState() => _mobileUsuarioState();
}

class _mobileUsuarioState extends State<mobileUsuario> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController senha = TextEditingController();
  TextEditingController senha2 = TextEditingController();
  TextEditingController senha3 = TextEditingController();
  AuthService authController = AuthService();
  bool _showPsswd = false;
  bool _showPsswd2 = false;
  bool _showPsswd3 = false;
  bool ignoring = false;
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

  TextEditingController usuario = TextEditingController();
  void _mostrarDialogo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Digite a Senha'),
          content: TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Senha',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para verificar a senha aqui
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                accountEmail: Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
                decoration: BoxDecoration(color: Color(0xFF1b263b)),
              ),
              ListTile(
                leading: const Icon(Icons.logout_sharp, color: Colors.white),
                title: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  await authController.signOut(context);
                  // Navigator.popUntil(context, (route) => route.isFirst);;
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
                    decoration: const BoxDecoration(
                      color: Color(0xFFe0e1dd),
                    ),
                    child: Form(
                        key: _formKey,
                        child: ListView(children: [
                          Column(children: [
                            Container(
                                margin: const EdgeInsets.all(70),
                                child: Column(children: [
                                  const Text(
                                    "Escolha o usuário",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Color(0xFF1b263b),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                      height: 660,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFF1b263b)
                                              .withOpacity(0.5),
                                          border: Border.all(
                                            color: const Color(0xFF1b263b),
                                          )),
                                      child: Container(
                                        child: Column(children: [
                                          Card(
                                            elevation: 8,
                                            color: const Color(0xFF1b263b),
                                            margin: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                const ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(Icons.person,
                                                        color: Colors.yellow),
                                                  ),
                                                  title: Text(
                                                    'Marques 1',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 40),
                                                  child: TextFormField(
                                                    controller: senha,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                      fillColor:
                                                          const Color(0xFF1b263b),
                                                      labelText: 'Senha',
                                                      suffixIcon:
                                                          GestureDetector(
                                                              child: Icon(
                                                                _showPsswd == false
                                                                    ? Icons
                                                                        .visibility_off
                                                                    : Icons
                                                                        .visibility,
                                                                color: Colors
                                                                    .white,
                                                                size: 18,
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  _showPsswd =
                                                                      !_showPsswd;
                                                                });
                                                              }),
                                                    ),
                                                    obscureText:
                                                        _showPsswd == false
                                                            ? true
                                                            : false,
                                                    validator: (text) {
                                                      if (text == null ||
                                                          text.isEmpty) {
                                                        return 'Campo requerido!';
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ButtonBar(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (senha.text ==
                                                            'agencia') {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const visualPage()));
                                                        } else {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                    title: SizedBox(
                                                                        width: 30,
                                                                        height: 70,
                                                                        child: Column(children: [
                                                                          const Center(
                                                                            child:
                                                                                Text(
                                                                              'Senha incorreta',
                                                                              style: TextStyle(color: Color(0xFF1b263b)),
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text('Digitar novamente'))
                                                                        ])));
                                                              });
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Entrar',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF1b263b)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Card(
                                            elevation: 8,
                                            color: const Color(0xFF1b263b),
                                            margin: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                const ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(Icons.person,
                                                        color: Colors.green),
                                                  ),
                                                  title: Text(
                                                    'Marques 2 ',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 40),
                                                  child: TextFormField(
                                                    controller: senha2,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                      fillColor:
                                                          const Color(0xFF1b263b),
                                                      labelText: 'Senha',
                                                      suffixIcon:
                                                          GestureDetector(
                                                              child: Icon(
                                                                _showPsswd2 ==
                                                                        false
                                                                    ? Icons
                                                                        .visibility_off
                                                                    : Icons
                                                                        .visibility,
                                                                color: Colors
                                                                    .white,
                                                                size: 18,
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  _showPsswd2 =
                                                                      !_showPsswd2;
                                                                });
                                                              }),
                                                    ),
                                                    obscureText:
                                                        _showPsswd2 == false
                                                            ? true
                                                            : false,
                                                    validator: (text) {
                                                      if (text == null ||
                                                          text.isEmpty) {
                                                        return 'Campo requerido!';
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ButtonBar(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (senha2.text ==
                                                            'pessoal') {
                                                          RouterManager.router
                                                              .navigateTo(
                                                                  context,
                                                                  '/visualPageMobile2');
                                                        } else {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                    title: SizedBox(
                                                                        width: 30,
                                                                        height: 70,
                                                                        child: Column(children: [
                                                                          const Center(
                                                                            child:
                                                                                Text(
                                                                              'Senha incorreta',
                                                                              style: TextStyle(color: Color(0xFF1b263b)),
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text('Digitar novamente'))
                                                                        ])));
                                                              });
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Entrar',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF1b263b)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Card(
                                            elevation: 8,
                                            color: const Color(0xFF1b263b),
                                            margin: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                const ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(Icons.person,
                                                        color: Colors.orange),
                                                  ),
                                                  title: Text(
                                                    'Marques 3',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 40),
                                                  child: TextFormField(
                                                    controller: senha3,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                      fillColor:
                                                          const Color(0xFF1b263b),
                                                      labelText: 'Senha',
                                                      suffixIcon:
                                                          GestureDetector(
                                                              child: Icon(
                                                                _showPsswd3 ==
                                                                        false
                                                                    ? Icons
                                                                        .visibility_off
                                                                    : Icons
                                                                        .visibility,
                                                                color: Colors
                                                                    .white,
                                                                size: 18,
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  _showPsswd3 =
                                                                      !_showPsswd3;
                                                                });
                                                              }),
                                                    ),
                                                    obscureText:
                                                        _showPsswd3 == false
                                                            ? true
                                                            : false,
                                                    validator: (text) {
                                                      if (text == null ||
                                                          text.isEmpty) {
                                                        return 'Campo requerido!';
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ButtonBar(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (senha3.text ==
                                                            'parceiro') {
                                                          RouterManager.router
                                                              .navigateTo(
                                                                  context,
                                                                  '/visualPageMobile3');
                                                        } else {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                    title: SizedBox(
                                                                        width: 30,
                                                                        height: 70,
                                                                        child: Column(children: [
                                                                          const Center(
                                                                            child:
                                                                                Text(
                                                                              'Senha incorreta',
                                                                              style: TextStyle(color: Color(0xFF1b263b)),
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text('Digitar novamente'))
                                                                        ])));
                                                              });
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Entrar',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF1b263b)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                      ))
                                ]))
                          ])
                        ]))))));
  }
}
