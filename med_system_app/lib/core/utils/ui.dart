import 'package:flutter/material.dart';

showAlert({
  required String title,
  required String content,
  required String textYes,
  required String textNo,
  required VoidCallback onPressedConfirm,
  required VoidCallback onPressedCancel,
  required BuildContext context,
}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: onPressedCancel,
            child: Text(textNo),
          ),
          ElevatedButton(
            onPressed: onPressedConfirm,
            child: Text(textYes),
          ),
        ],
      );
    },
  );
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
