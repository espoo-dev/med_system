import 'package:flutter/material.dart';

Widget buildFAB(BuildContext context, VoidCallback onPressed) =>
    AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.edit,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        label: const SizedBox(),
      ),
    );
