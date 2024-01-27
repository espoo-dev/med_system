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
