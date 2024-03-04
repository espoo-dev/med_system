import 'package:flutter/material.dart';

class MyRadioGroup extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  final String? initialValue;

  const MyRadioGroup({
    super.key,
    required this.onValueChanged,
    this.initialValue = 'ward',
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyRadioGroupState createState() => _MyRadioGroupState();
}

class _MyRadioGroupState extends State<MyRadioGroup> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    // Define o valor inicial padrão como "Enfermaria"
    _selectedValue = 'Enfermaria';

    // Se o valor inicial for diferente de "ward", define como "Apartamento"
    if (widget.initialValue != 'ward') {
      _selectedValue = 'Apartamento';
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
              value: 'Enfermaria',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                });
                widget.onValueChanged(_selectedValue);
              },
            ),
            const Text('Enfermaria'),
            Radio(
              value: 'Apartamento',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                });
                widget.onValueChanged(_selectedValue);
              },
            ),
            const Text('Apartamento'),
          ],
        ),
      ],
    );
  }
}
