import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInputTime extends StatefulWidget {
  String? label;
  final Color? labelStyleColor;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final TimeOfDay? selectedTime; // Changed to final
  final Function? onChanged;    // Changed to final

  MyInputTime({
    super.key,
    @required this.label,
    this.selectedTime,
    this.onChanged,
    this.labelStyleColor,
    this.fillColor,
    this.borderColor,
    this.textColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyInputTimeState createState() => _MyInputTimeState();
}

class _MyInputTimeState extends State<MyInputTime> {
  TimeOfDay? _internalSelectedTime;

  @override
  void initState() {
    super.initState();
    _internalSelectedTime = widget.selectedTime;
    // Initial onChanged call removed as it might be redundant or override controller/vm logic with old state if vm is trying to set it.
  }

  @override
  void didUpdateWidget(MyInputTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTime != oldWidget.selectedTime) {
      _internalSelectedTime = widget.selectedTime;
    }
  }

  String getSelectedTimeString() {
    if (_internalSelectedTime == null) return '';

    String hour = _internalSelectedTime!.hour.toString().padLeft(2, '0');
    String minute = _internalSelectedTime!.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  Future<void> _selectTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: _internalSelectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context),
          child: child ?? Container(),
        );
      },
    );

    if (time != null) {
      setState(() {
        _internalSelectedTime = time;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(getSelectedTimeString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          fillColor: widget.fillColor ?? Theme.of(context).colorScheme.primary,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color:
                  widget.borderColor ?? Theme.of(context).colorScheme.primary,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          getSelectedTimeString(),
          style: TextStyle(
            color: widget.textColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
