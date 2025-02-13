import 'package:flutter/material.dart';
import 'package:flutter_web/auth/authentic.dart';

class mobileAppBar extends StatelessWidget {
  const mobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authController = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/imagem5.png',
          fit: BoxFit.contain,
          width: 100,
          height: 100,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Seu Nome'),
              accountEmail: Text('seu_email@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Página Inicial'),
              onTap: () {
                // Adicione a lógica para navegar para a página inicial
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                // Adicione a lógica para navegar para a tela de configurações
                Navigator.pop(context);
              },
            ),
            // Adicione mais itens conforme necessário
          ],
        ),
      ),
      body: const Center(
        child: Text('Conteúdo da Página Principal'),
      ),
    );
  }
}
