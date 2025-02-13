import 'package:flutter/material.dart';

import 'package:flutter_web/Page/cadastrarPage/mobileCadastrarPage.dart';

import 'package:flutter_web/Page/cadastrarPage/webCadastrarPage.dart';

class cadastrarPage extends StatelessWidget {
  const cadastrarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexto, constraints) {
      return Scaffold(
        body: constraints.maxWidth < 800
            ? const PreferredSize(
                preferredSize: Size(double.infinity, 56),
                child: mobileCadastrarPage(),
              )
            : const PreferredSize(
                preferredSize: Size(double.infinity, 72),
                child: webCadastrarPage()),
      );
    });
  }
}
