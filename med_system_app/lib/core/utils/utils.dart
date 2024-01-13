import 'package:flutter/material.dart';

showSnack(BuildContext context, String message, Color? color) {
  final snackBar = SnackBar(
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
