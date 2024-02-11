import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RealInputFormatter extends TextInputFormatter {
  final bool moeda;

  RealInputFormatter({this.moeda = false});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    double value =
        double.parse(newValue.text.replaceAll(RegExp('[^0-9]'), '')) / 100;

    String newText = moeda ? 'R\$ ' : '';
    newText += NumberFormat.currency(locale: 'pt_BR', symbol: '').format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
