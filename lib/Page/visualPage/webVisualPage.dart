import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_web/Page/visualPage/listTestweb.dart';
import 'package:flutter_web/auth/authentic.dart';

import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/homePage.dart';
import 'package:flutter_web/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class webVisualPage extends StatefulWidget {
  const webVisualPage({super.key});

  @override
  State<webVisualPage> createState() => _webVisualPageState();
}

class _webVisualPageState extends State<webVisualPage> {
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
    AuthService authController = AuthService();
    List<Usua> allusua = [];
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
                          child: Icon(Icons.person, color: Colors.yellow),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Agência',
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
                                .navigateTo(context, '/visualPage');
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
                                .navigateTo(context, '/cadastrarPage');
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
                              await authController.signOut(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const homePage()));
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
                    decoration: const BoxDecoration(
                      color: Color(0xFFe0e1dd),
                    ),
                    child: ListView(children: [
                      Column(children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.all(40),
                          child: const Text(
                            "Lista de Clientes",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF1b263b),
                            ),
                          ),
                        ),
                        Container(
                          width: 650,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF1b263b).withOpacity(0.5),
                              border: Border.all(
                                color: const Color(0xFF1b263b),
                              )),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Clientes')
                                .orderBy('nome')
                                .snapshots(),
                            builder: (context, snp) {
                              if (snp.hasError) {
                                return const Center(
                                  child: Text('Erro'),
                                );
                              }
                              if (snp.hasData) {
                                allusua = snp.data!.docs
                                    .map((doc) => Usua.fromJson(
                                        doc.data() as Map<String, dynamic>))
                                    .toList();

                                return SizedBox(
                                    height: 300 *
                                        allusua.length
                                            .toDouble(), // Ajuste conforme necessário
                                    child: listWeb(users: allusua));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator(
                                        color: Color(0xFF1b263b)));
                              }
                            },
                          ),
                        )
                      ])
                    ])))));
  }
}
