import 'package:fluro/fluro.dart';
import 'package:flutter_web/usuario%202/web/webCadastrarPage2.dart';
import 'package:flutter_web/usuario%202/web/webVisualPage2.dart';

import 'package:flutter_web/Page/homePage/mobileHomePage.dart';
import 'package:flutter_web/Page/homePage/webHomePage.dart';

import 'package:flutter_web/cadastrarPage.dart';
import 'package:flutter_web/homePage.dart';
import 'package:flutter_web/landingPage.dart';
import 'package:flutter_web/loanding.dart';
import 'package:flutter_web/usuario%203/mobile/mobileCadastrarPage3.dart';
import 'package:flutter_web/usuario%203/mobile/mobileVIsualPage3.dart';
import 'package:flutter_web/usuario%203/web/webCadastrarPage3.dart';
import 'package:flutter_web/usuario%203/web/webVisualPage3.dart';
import 'package:flutter_web/usuarios/mobileUsuario.dart';
import 'package:flutter_web/usuarios/usuario.dart';
import 'package:flutter_web/usuarios/webUsuario.dart';
import 'package:flutter_web/visualPage.dart';

import 'usuario 2/mobile/mobileCadastrarPage2.dart';
import 'usuario 2/mobile/mobileVIsualPage2.dart';

class RouterManager {
  static late FluroRouter router;

  static void configureRoutes() {
    router = FluroRouter();
    router.define(
      '/',
      handler: Handler(handlerFunc: (_, __) => const landingPage()),
    );
    router.define(
      '/loading',
      handler: Handler(handlerFunc: (_, __) => const Loanding()),
    );
    router.define(
      '/homePage',
      handler: Handler(handlerFunc: (_, __) => const homePage()),
    );
    router.define(
      '/mobileHomePage',
      handler: Handler(handlerFunc: (_, __) => const mobileHomePage()),
    );
    router.define(
      '/webHomePage',
      handler: Handler(handlerFunc: (_, __) => const webHomePage()),
    );
    router.define(
      '/visualPage',
      handler: Handler(handlerFunc: (_, __) => const visualPage()),
    );
    router.define(
      '/cadastrarPage',
      handler: Handler(handlerFunc: (_, __) => const cadastrarPage()),
    );
    router.define(
      '/cadastrarPage2',
      handler: Handler(handlerFunc: (_, __) => const webCadastrarPage2()),
    );
    router.define(
      '/visualPage2',
      handler: Handler(handlerFunc: (_, __) => const webVisualPage2()),
    );
    router.define(
      '/cadastrarPageMobile2',
      handler: Handler(handlerFunc: (_, __) => const mobileCadastrarPage2()),
    );
    router.define(
      '/visualPageMobile2',
      handler: Handler(handlerFunc: (_, __) => const mobileVisualPage2()),
    );
    router.define(
      '/webUsuario',
      handler: Handler(handlerFunc: (_, __) => const webUsuario()),
    );
    router.define(
      '/usuario',
      handler: Handler(handlerFunc: (_, __) => const usuario()),
    );
    router.define(
      '/mobileUsuario',
      handler: Handler(handlerFunc: (_, __) => const mobileUsuario()),
    );
    router.define(
      '/cadastrarPage3',
      handler: Handler(handlerFunc: (_, __) => const webCadastrarPage3()),
    );
    router.define(
      '/visualPage3',
      handler: Handler(handlerFunc: (_, __) => const webVisualPage3()),
    );
    router.define(
      '/cadastrarPageMobile3',
      handler: Handler(handlerFunc: (_, __) => const mobileCadastrarPage3()),
    );
    router.define(
      '/visualPageMobile3',
      handler: Handler(handlerFunc: (_, __) => const mobileVisualPage3()),
    );
    // Adicione outras rotas conforme necessário
  }
}
