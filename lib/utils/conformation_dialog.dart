import 'package:flutter/material.dart';

Future<bool?>? confirmationDialog({
  required BuildContext context,
  required String msg,
  String confirmationText = 'Ok',
  String cancelText = 'Cancelar',
}) async {
  return await showDialog(
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
              child: Text(confirmationText),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
                child: Text(cancelText),
                onPressed: () => Navigator.pop(context, false)),
          ],
        );
      });
}
