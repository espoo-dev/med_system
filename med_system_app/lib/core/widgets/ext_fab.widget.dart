import 'package:flutter/material.dart';

Widget buildExtendedFAB(
    BuildContext context, String buttonText, Function onPressed) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    curve: Curves.linear,
    width: 200,
    height: 50,
    child: FloatingActionButton.extended(
      onPressed: () {
        onPressed();
      },
      icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
      label: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    ),
  );
}
