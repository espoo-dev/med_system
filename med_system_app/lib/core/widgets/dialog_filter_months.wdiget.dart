import 'package:flutter/material.dart';

Future<int?> showDialogMonths(BuildContext context, {int? initialMonth}) async {
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Escolha o Mês'),
        content: _buildMonthList(context, initialMonth),
      );
    },
  );
}

Widget _buildMonthList(BuildContext context, int? initialMonth) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(12, (index) {
        final monthNumber = index + 1;
        final monthName = _getMonthName(monthNumber);
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(monthName),
              if (initialMonth == monthNumber)
                Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
          onTap: () {
            Navigator.pop(context, monthNumber);
          },
          selected: initialMonth == monthNumber,
        );
      }),
    ),
  );
}

String _getMonthName(int monthNumber) {
  switch (monthNumber) {
    case 1:
      return 'Janeiro';
    case 2:
      return 'Fevereiro';
    case 3:
      return 'Março';
    case 4:
      return 'Abril';
    case 5:
      return 'Maio';
    case 6:
      return 'Junho';
    case 7:
      return 'Julho';
    case 8:
      return 'Agosto';
    case 9:
      return 'Setembro';
    case 10:
      return 'Outubro';
    case 11:
      return 'Novembro';
    case 12:
      return 'Dezembro';
    default:
      return '';
  }
}
