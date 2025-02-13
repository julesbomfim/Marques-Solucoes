import 'package:flutter/material.dart';
import 'package:flutter_web/router.dart';
import 'package:lottie/lottie.dart';

class mobileLoandingScreen extends StatefulWidget {
  const mobileLoandingScreen({super.key});
  @override
  _mobileLoandingScreenState createState() => _mobileLoandingScreenState();
}

class _mobileLoandingScreenState extends State<mobileLoandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat(reverse: true);

    // Adiciona um atraso simulando um processo de carregamento
    Future.delayed(const Duration(seconds: 7), () {
      // Navega para a próxima tela após o atraso
      RouterManager.router.navigateTo(context, '/visualPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Center(
                    child: FadeTransition(
                      opacity: _animation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.network(
                              "https://lottie.host/51e69a02-805d-40f2-af87-8167ab7247dd/lQzGhUoTNx.json",
                              height: 300,
                              width: 300),
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
