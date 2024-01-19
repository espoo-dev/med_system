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

String greet() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour < 0 || hour > 23) {
    throw Exception('Hora fora do intervalo permitido (0-23)');
  }

  if (hour < 12) {
    return 'Bom dia!';
  } else if (hour < 18) {
    return 'Boa tarde!';
  } else {
    return 'Boa noite!';
  }
}
