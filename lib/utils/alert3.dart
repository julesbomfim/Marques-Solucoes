import 'package:flutter/material.dart';
import 'package:flutter_web/usuario%203/web/webVisualPage3.dart';

Future alertDialog4(
  BuildContext context,
  String msg,
) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            msg,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const webVisualPage3()));
              },
            ),
          ],
        );
      });
}
