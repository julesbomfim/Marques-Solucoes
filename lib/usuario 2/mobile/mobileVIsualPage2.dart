import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_web/dados/user.dart';
import 'package:flutter_web/router.dart';
import 'package:flutter_web/usuario%202/mobile/listTestMobile2.dart';
import 'package:flutter_web/usuario%202/web/authetic2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mobileVisualPage2 extends StatefulWidget {
  const mobileVisualPage2({super.key});

  @override
  State<mobileVisualPage2> createState() => _mobileVisualPage2State();
}

class _mobileVisualPage2State extends State<mobileVisualPage2> {
  AuthService2 authController2 = AuthService2();

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
    List<Usua> allusua = [];
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
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF1b263b).withOpacity(0.5),
                              border: Border.all(
                                color: const Color(0xFF1b263b),
                              )),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Clientes2')
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
                                    height: 400 *
                                        allusua.length
                                            .toDouble(), // Ajuste conforme necessário
                                    child: listMobile3(users: allusua));
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
