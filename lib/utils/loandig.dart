import 'package:flutter/material.dart';

loadingDialog(BuildContext context, String msg) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: Color(0xFF1b263b),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                msg,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      });
}
