import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInputTime extends StatefulWidget {
  String? label;
  final Color? labelStyleColor;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  TimeOfDay? selectedTime;
  Function? onChanged;

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
  @override
  void initState() {
    super.initState();
    if (widget.selectedTime != null && widget.onChanged != null) {
      widget.onChanged!(getSelectedTimeString());
    }
  }

  String getSelectedTimeString() {
    if (widget.selectedTime == null) return '';

    String hour = widget.selectedTime!.hour.toString().padLeft(2, '0');
    String minute = widget.selectedTime!.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  Future<void> _selectTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context),
          child: child ?? Container(),
        );
      },
    );

    setState(() {
      if (time != null) {
        widget.selectedTime = time;
        if (widget.onChanged != null) {
          widget.onChanged!(getSelectedTimeString());
        }
      }
    });
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
