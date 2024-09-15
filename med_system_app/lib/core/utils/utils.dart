import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

TimeOfDay? stringToTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  if (parts.length == 2) {
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    }
  }
  return null;
}

DateTime? convertStringToDate(String dateString) {
  if (dateString.isEmpty) {
    return null;
  }

  List<String> dateParts = dateString.split('/');
  if (dateParts.length != 3) {
    return null;
  }

  int? day = int.tryParse(dateParts[0]);
  int? month = int.tryParse(dateParts[1]);
  int? year = int.tryParse(dateParts[2]);

  if (day == null || month == null || year == null) {
    return null;
  }

  return DateTime(year, month, day);
}

double stringToDouble(String value) {
  try {
    return double.parse(value);
  } catch (e) {
    return 0.0;
  }
}

extension StringExtension on String {
  String truncate() {
    if (length <= 13) {
      return this;
    } else {
      return '${substring(0, 10)}...';
    }
  }
}

int parseInt(String text) {
  String cleanedText = text.replaceAll(RegExp('[^0-9]'), '');
  int value = int.tryParse(cleanedText) ?? 0;

  return value;
}

String getMonthName() {
  final dateFormat = DateFormat.MMMM('pt_BR');
  final currentDate = DateTime.now();
  return dateFormat.format(currentDate);
}

int getMonthNumber() {
  final currentDate = DateTime.now();
  return currentDate.month;
}

String formatCurrency(double amount) {
  final NumberFormat formatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\$');
  return formatter.format(amount);
}

List<String> formatListToPtBr(List<String> values) {
  var inputFormat = NumberFormat.currency(locale: 'en_US', symbol: '');
  var outputFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  return values.map((value) {
    String cleanValue = value.replaceAll(RegExp(r'[^\d.,]'), '').trim();
    double number = inputFormat.parse(cleanValue) as double;
    return outputFormat.format(number);
  }).toList();
}
