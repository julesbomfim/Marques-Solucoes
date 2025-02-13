import 'package:flutter/material.dart';

import 'package:flutter_web/usuarios/mobileUsuario.dart';
import 'package:flutter_web/usuarios/webUsuario.dart';

class usuario extends StatelessWidget {
  const usuario({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexto, constraints) {
      return Scaffold(
        body: constraints.maxWidth < 800
            ? const PreferredSize(
                preferredSize: Size(double.infinity, 56),
                child: mobileUsuario(),
              )
            : const PreferredSize(
                preferredSize: Size(double.infinity, 72),
                child: webUsuario()),
      );
    });
  }
}
