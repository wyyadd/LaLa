import 'package:flutter/material.dart';

void showSnakeBar({required BuildContext context, required String message, int time = 1}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: time),
      backgroundColor: const Color(0xFF2E3466),
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
