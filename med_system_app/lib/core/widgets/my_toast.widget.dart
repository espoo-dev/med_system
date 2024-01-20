import 'package:flutter/material.dart';

enum ToastType { success, error, danger, info }

class CustomToast {
  static void show(
    BuildContext context, {
    required ToastType type,
    required String title,
    required String description,
  }) {
    IconData icon;
    Color iconColor;
    Color backgroundColor;

    switch (type) {
      case ToastType.success:
        icon = Icons.check;
        iconColor = Colors.white;
        backgroundColor = const Color(0xFF388E3C); // Success
        break;
      case ToastType.error:
        icon = Icons.error;
        iconColor = Colors.white;
        backgroundColor = Colors.red;
        break;
      case ToastType.danger:
        icon = Icons.warning;
        backgroundColor = const Color(0xFFF57C00); // D
        iconColor = Colors.white;
        break;
      case ToastType.info:
        icon = Icons.info;
        iconColor = Colors.white;
        backgroundColor = const Color(0xFF2196F3);
        break;
      default:
        backgroundColor = Colors.black; // Default to black
        icon = Icons.info;
        iconColor = Colors.white;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: CustomToastWidget(
          icon: icon,
          iconColor: iconColor,
          title: title,
          description: description,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class CustomToastWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const CustomToastWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
