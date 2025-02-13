import 'package:flutter/material.dart';

class mobileBarhHomePage extends StatelessWidget {
  const mobileBarhHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    ));
  }
}
