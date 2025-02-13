import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/auth/authentic.dart';
import 'package:flutter_web/usuarios/usuario.dart';
import 'package:flutter_web/utils/loandig.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mobileHomePage extends StatefulWidget {
  const mobileHomePage({super.key});

  @override
  State<mobileHomePage> createState() => _mobileHomePageState();
}

class _mobileHomePageState extends State<mobileHomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  AuthService authController = AuthService();
  bool _showPsswd = false;
  bool ignoring = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/imagem5.png',
            fit: BoxFit.contain,
            width: 90,
            height: 90,
          ),
          toolbarHeight: 72,
          elevation: 60,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 233, 232, 232),
            ),
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
                        child: ListView(
                          children: [
                            Lottie.network(
                                "https://lottie.host/edc1e48e-2dbc-4e97-a93b-1975c4d12c63/cGuvXC5oy8.json",
                                height: 300,
                                width: 400),
                            Container(
                              margin: const EdgeInsets.all(70),
                              child: Column(children: [
                                const Text(
                                  "Login",
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
                                TextFormField(
                                  controller: emailController,
                                  autofocus: true,
                                  style: const TextStyle(
                                      fontSize: 15, color: Color(0xFF1b263b)),
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1b263b),
                                        ),
                                      ),
                                      border: UnderlineInputBorder(),
                                      labelText: 'E-mail',
                                      labelStyle:
                                          TextStyle(color: Color(0xFF1b263b))),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Campo requerido!';
                                    }

                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(text.trim());

                                    if (!emailValid) {
                                      return 'E-mail inválido.';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  style: const TextStyle(
                                      fontSize: 15, color: Color(0xFF1b263b)),
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF1b263b)),
                                    ),
                                    border: const UnderlineInputBorder(),
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF1b263b)),
                                    fillColor: const Color(0xFF1b263b),
                                    labelText: 'Senha',
                                    suffixIcon: GestureDetector(
                                        child: Icon(
                                          _showPsswd == false
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: const Color(0xFF1b263b),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _showPsswd = !_showPsswd;
                                          });
                                        }),
                                  ),
                                  obscureText:
                                      _showPsswd == false ? true : false,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Campo requerido!';
                                    }

                                    return null;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text('Esqueci a senha',
                                          style: TextStyle(
                                              color: Color(0xFF1b263b))),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: SizedBox(
                                                    height: 340,
                                                    width: 300,
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const Text(
                                                          'Insira o e-mail para recuperação de senha',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF1b263b),
                                                              fontSize: 20),
                                                        ),
                                                        const SizedBox(
                                                          height: 40,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              authController
                                                                  .emailController,
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                UnderlineInputBorder(),
                                                            hintText:
                                                                'E-mail de recuperação',
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(60),
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                authController
                                                                    .resetPassword(
                                                                        context);
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (context) =>
                                                                        AlertDialog(
                                                                            content:
                                                                                SizedBox(
                                                                          height:
                                                                              300,
                                                                          width:
                                                                              300,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Icon(Icons.check_circle_outline_outlined, color: Colors.green, size: 100),
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(top: 15),
                                                                                  child: const Text(
                                                                                    'Um link foi enviado para o e-mail de recuperação',
                                                                                    style: TextStyle(
                                                                                      fontSize: 20,
                                                                                      color: Color(0xFF1b263b),
                                                                                      decoration: TextDecoration.none,
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 200,
                                                                                  margin: const EdgeInsets.all(40),
                                                                                  child: ElevatedButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xFF1b263b)),
                                                                                    ),
                                                                                    child: const Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.exit_to_app_outlined,
                                                                                          size: 16,
                                                                                          color: Color.fromARGB(255, 255, 255, 255),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 15,
                                                                                        ),
                                                                                        Text(
                                                                                          'Voltar',
                                                                                          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )));
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.resolveWith(
                                                                        (states) =>
                                                                            const Color(0xFF0d1b2a)),
                                                              ),
                                                              child: const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .send,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(8),
                                                                    child: Text(
                                                                        'Enviar',
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                255))),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10.0),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState == null ||
                                            !_formKey.currentState!
                                                .validate()) {
                                          return;
                                        }
                                        loadingDialog(context, 'Carregando...');

                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Navigator.pop(context);
                                        final message =
                                            await AuthService().login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );

                                        if (message!.contains(
                                          'Success',
                                        )) {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const usuario()),
                                          );
                                        }

                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //     content: Text(
                                        //       message,
                                        //       selectionColor: Colors.green,
                                        //     ),
                                        //   ),
                                        // );
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
                                          Icon(Icons.login,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 10.0),
                                            child: Text('Login',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ),
                                        ],
                                      )),
                                ),
                              ]),
                            )
                          ],
                        ))))));
  }

  /* login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (userCredential != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homePage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email incorreto') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Usuário não encontrado'),
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'senha incorreta') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Senha incorreta'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }*/
}
