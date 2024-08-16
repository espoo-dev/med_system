import 'package:flutter/material.dart';

class MyRadioGroupWorkLoad extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  final String? initialValue;

  const MyRadioGroupWorkLoad({
    super.key,
    required this.onValueChanged,
    this.initialValue = 'six',
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyRadioGroupState createState() => _MyRadioGroupState();
}

class _MyRadioGroupState extends State<MyRadioGroupWorkLoad> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue == 'six' ||
        widget.initialValue == 'twelve' ||
        widget.initialValue == 'twenty_four') {
      _selectedValue = widget.initialValue!;
    } else {
      _selectedValue = 'six';
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
              value: 'six',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                });
                widget.onValueChanged(_selectedValue);
              },
            ),
            const Text('6 horas'),
            Radio(
              value: 'twelve',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                });
                widget.onValueChanged(_selectedValue);
              },
            ),
            const Text('12 horas'),
            Radio(
              value: 'twenty_four',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                });
                widget.onValueChanged(_selectedValue);
              },
            ),
            const Text('24 horas'),
          ],
        ),
      ],
    );
  }
}
