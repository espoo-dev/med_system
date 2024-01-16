import 'package:flutter/material.dart';

Widget buildExtendedFAB() => AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 150,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.edit),
        label: const Center(
          child: Text(
            "Novo evento",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
