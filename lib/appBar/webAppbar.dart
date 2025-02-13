import 'package:flutter/material.dart';
import 'package:flutter_web/auth/authentic.dart';
import 'package:flutter_web/cadastrarPage.dart';
import 'package:flutter_web/homePage.dart';
import 'package:flutter_web/visualPage.dart';

class webAppBar extends StatelessWidget {
  const webAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authController = AuthService();
    return AppBar(
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
                      width: 840,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            color: Color(0xFF1b263b), fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const visualPage()));
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const cadastrarPage()));
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const cadastrarPage()));
                      },
                      child: const Text(
                        'Sobre',
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
    );
  }
}
