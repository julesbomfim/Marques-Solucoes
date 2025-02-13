import 'package:flutter/material.dart';

class webBarhHomePage extends StatelessWidget {
  const webBarhHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
    ));
  }
}
