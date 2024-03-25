import 'package:flutter/material.dart';

class MyRadioGroupPayment extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  final String? initialValue;

  const MyRadioGroupPayment({
    super.key,
    required this.onValueChanged,
    this.initialValue = 'health_insurance',
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyRadioGroupPayentState createState() => _MyRadioGroupPayentState();
}

class _MyRadioGroupPayentState extends State<MyRadioGroupPayment> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = 'Convênio';
    if (widget.initialValue != 'health_insurance') {
      _selectedValue = 'Outros';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              value: 'Convênio',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                });
                widget.onValueChanged(_selectedValue);
              },
            ),
            const Text('Convênio'),
            Radio(
              value: 'Outros',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                });
                widget.onValueChanged(_selectedValue);
              },
            ),
            const Text('Outros'),
          ],
        ),
      ],
    );
  }
}
