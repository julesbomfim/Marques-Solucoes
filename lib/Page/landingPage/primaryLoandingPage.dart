import 'package:flutter/material.dart';
import 'package:flutter_web/router.dart';
import 'package:lottie/lottie.dart';

class primaryLoanding extends StatefulWidget {
  const primaryLoanding({super.key});
  @override
  _primaryLoandingState createState() => _primaryLoandingState();
}

class _primaryLoandingState extends State<primaryLoanding>
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
    Future.delayed(const Duration(seconds: 9), () {
      // Navega para a próxima tela após o atraso
      RouterManager.router.navigateTo(context, '/homePage');
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
                          Expanded(
                            child: Lottie.network(
                                "https://lottie.host/0454ef59-5959-4ff9-a280-24f60cfd6aee/VtDFQZmu6W.json",
                                height: 500,
                                width: 500),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.all(40),
                              child: const Text(
                                "Marques Soluções e Consultoria",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color(0xFF1b263b),
                                ),
                              ),
                            ),
                          )
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
