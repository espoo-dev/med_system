import 'package:flutter/material.dart';

class ColorHelper {
  /// Converte uma cor para string hexadecimal (ex: "#FF5733")
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  /// Converte uma string hexadecimal para Color
  /// Aceita formatos: "#FF5733", "FF5733", "#AAFF5733"
  static Color hexToColor(String? hexString, {Color defaultColor = Colors.blue}) {
    if (hexString == null || hexString.isEmpty) {
      return defaultColor;
    }

    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) {
        buffer.write('ff');
      }
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return defaultColor;
    }
  }

  /// Retorna uma cor padrão para plantões (azul)
  static Color get defaultMedicalShiftColor => Colors.blue;

  /// Lista de cores sugeridas para plantões
  static List<Color> get suggestedColors => const [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.purple,
        Colors.red,
        Colors.teal,
        Colors.pink,
        Colors.indigo,
        Colors.amber,
        Colors.cyan,
      ];
}
