import 'package:flutter/material.dart';
import 'package:flutter_web/Page/homePage/mobileHomePage.dart';

import 'package:flutter_web/Page/homePage/webHomePage.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexto, constraints) {
      return Scaffold(
        body: constraints.maxWidth < 800
            ? const PreferredSize(
                preferredSize: Size(double.infinity, 56),
                child: mobileHomePage(),
              )
            : const PreferredSize(
                preferredSize: Size(double.infinity, 72),
                child: webHomePage()),
      );
    });
  }
}
