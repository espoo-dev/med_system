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

    _selectedValue = 'ward';

    if (widget.initialValue != 'ward') {
      _selectedValue = 'apartment';
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
              value: 'ward',
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
              value: 'apartment',
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
