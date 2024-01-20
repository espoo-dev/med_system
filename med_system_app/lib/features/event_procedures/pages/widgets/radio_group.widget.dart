import 'package:flutter/material.dart';

class MyRadioGroup extends StatefulWidget {
  final ValueChanged<String> onValueChanged;

  const MyRadioGroup({super.key, required this.onValueChanged});

  @override
  // ignore: library_private_types_in_public_api
  _MyRadioGroupState createState() => _MyRadioGroupState();
}

class _MyRadioGroupState extends State<MyRadioGroup> {
  String _selectedValue = 'Enfermaria';

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
