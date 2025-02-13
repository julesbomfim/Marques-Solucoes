import 'package:flutter/material.dart';
import 'package:flutter_web/Page/loandingPage/loandingPage.dart';
import 'package:flutter_web/Page/loandingPage/mobilelLoandingPage.dart';

class Loanding extends StatelessWidget {
  const Loanding({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexto, constraints) {
      return Scaffold(
        body: constraints.maxWidth < 1000
            ? const PreferredSize(
                preferredSize: Size(double.infinity, 56),
                child: mobileLoandingScreen(),
              )
            : const PreferredSize(
                preferredSize: Size(double.infinity, 72),
                child: LoadingScreen()),
      );
    });
  }
}
