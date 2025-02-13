import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/usuario%202/mobile/mobileCadastrarPage2.dart';
import 'package:flutter_web/usuario%202/mobile/mobileVIsualPage2.dart';
import 'package:flutter_web/usuario%202/web/webCadastrarPage2.dart';

import 'package:flutter_web/cadastrarPage.dart';

import 'package:flutter_web/homePage.dart';
import 'package:flutter_web/landingPage.dart';
import 'package:flutter_web/loanding.dart';
import 'package:flutter_web/router.dart';
import 'package:flutter_web/usuario%202/web/webVisualPage2.dart';
import 'package:flutter_web/usuario%203/mobile/mobileCadastrarPage3.dart';
import 'package:flutter_web/usuario%203/mobile/mobileVIsualPage3.dart';
import 'package:flutter_web/usuario%203/web/webCadastrarPage3.dart';
import 'package:flutter_web/usuario%203/web/webVisualPage3.dart';
import 'package:flutter_web/usuarios/usuario.dart';

import 'package:flutter_web/visualPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA393_So7qkETtiE8MwHP66D6NkPueaKEQ",
          projectId: "marques-78d12",
          storageBucket: "marques-78d12.appspot.com",
          messagingSenderId: "355323418861",
          appId: "1:355323418861:web:201ab45d7f146d689394e4"));
  RouterManager.configureRoutes();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marques Soluções e Consultoria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Montserrat"),
      home: const landingPage(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return _getRouteWidget(context, settings);
          },
        );
      },
    );
  }
}

Widget _getRouteWidget(BuildContext context, RouteSettings settings) {
  // Implement your route logic here
  // You can use settings.name to determine the route
  if (settings.name == '/homePage') {
    return const homePage();
  } else if (settings.name == '/visualPage') {
    return const visualPage();
  } else if (settings.name == '/loanding') {
    return const Loanding();
  } else if (settings.name == '/cadastrarPage') {
    return const cadastrarPage();
  } else if (settings.name == '/cadastrarPage2') {
    return const webCadastrarPage2();
  } else if (settings.name == '/Usuario') {
    return const usuario();
  } else if (settings.name == '/cadastrarPage2') {
    return const webCadastrarPage2();
  } else if (settings.name == '/visualPage2') {
    return const webVisualPage2();
  } else if (settings.name == '/cadastrarPageMobile2') {
    return const mobileCadastrarPage2();
  } else if (settings.name == '//visualPageMobile2') {
    return const mobileVisualPage2();
  } else if (settings.name == '/cadastrarPage3') {
    return const webCadastrarPage3();
  } else if (settings.name == '/visualPage3') {
    return const webVisualPage3();
  } else if (settings.name == '/cadastrarPageMobile3') {
    return const mobileCadastrarPage3();
  } else if (settings.name == '//visualPageMobile3') {
    return const mobileVisualPage3();
  } else {
    return const landingPage();
  }
}
