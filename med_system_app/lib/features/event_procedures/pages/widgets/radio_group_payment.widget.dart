import 'package:flutter/material.dart';

class MyRadioGroupPayment extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  final String? initialValue;

  const MyRadioGroupPayment({
    super.key,
    required this.onValueChanged,
    this.initialValue = 'convenio',
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyRadioGroupState createState() => _MyRadioGroupState();
}

class _MyRadioGroupState extends State<MyRadioGroupPayment> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = 'Convênio';
    if (widget.initialValue != 'convenio') {
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
