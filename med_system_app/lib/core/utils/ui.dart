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
  GlobalKey<State> dialogKey = GlobalKey<State>();

  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        key: dialogKey,
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              onPressedCancel();
              Navigator.of(context).pop();
            },
            child: Text(textNo),
          ),
          ElevatedButton(
            onPressed: () {
              onPressedConfirm();
              Navigator.of(context).pop();
            },
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

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
