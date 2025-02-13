import 'package:flutter/material.dart';
import 'package:flutter_web/Page/landingPage/primaryLoandingPage.dart';
import 'package:flutter_web/Page/landingPage/primaryMobile.dart';

class landingPage extends StatelessWidget {
  const landingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexto, constraints) {
      return Scaffold(
        body: constraints.maxWidth < 800
            ? const PreferredSize(
                preferredSize: Size(double.infinity, 56),
                child: primaryLoandingMobile(),
              )
            : const PreferredSize(
                preferredSize: Size(double.infinity, 72),
                child: primaryLoanding()),
      );
    });
  }
}
