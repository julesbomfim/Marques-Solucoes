import 'package:flutter/material.dart';
import 'package:flutter_web/Page/visualPage/mobileVisualPage.dart';
import 'package:flutter_web/Page/visualPage/webVisualPage.dart';

class visualPage extends StatefulWidget {
  const visualPage({super.key});

  @override
  State<visualPage> createState() => _visualPageState();
}

class _visualPageState extends State<visualPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexto, constraints) {
      return Scaffold(
        body: constraints.maxWidth < 800
            ? const PreferredSize(
                preferredSize: Size(double.infinity, 56),
                child: mobileVisualPage(),
              )
            : const PreferredSize(
                preferredSize: Size(double.infinity, 72),
                child: webVisualPage()),
      );
    });
  }
}
