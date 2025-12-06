import 'package:flutter/material.dart';

class MyFabButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const MyFabButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(icon, color: Colors.white),
    );
  }
}
