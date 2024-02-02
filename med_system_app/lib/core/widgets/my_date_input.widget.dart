import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInputDate extends StatefulWidget {
  String? label;
  final Color? labelStyleColor;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  DateTime? selectedDate;
  Function? onChanged;

  MyInputDate({
    super.key,
    @required this.label,
    this.selectedDate,
    this.onChanged,
    this.labelStyleColor,
    this.fillColor,
    this.borderColor,
    this.textColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyInputDateState createState() => _MyInputDateState();
}

class _MyInputDateState extends State<MyInputDate> {
  @override
  void initState() {
    super.initState();
    if (widget.selectedDate != null && widget.onChanged != null) {
      widget.onChanged!(getSelectedDateString());
    }
  }

  String getSelectedDateString() {
    if (widget.selectedDate == null) return '';

    String day = widget.selectedDate!.day.toString();
    String month = widget.selectedDate!.month.toString();
    String year = widget.selectedDate!.year.toString();

    return '$day/$month/$year';
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      helpText: 'Selecione a data',
      locale: const Locale('pt', 'BR'),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: widget.selectedDate ??
          DateTime(DateTime.now().year, DateTime.now().month, 1),
      firstDate: DateTime(2001),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    setState(() {
      if (date != null) {
        widget.selectedDate = date;
        if (widget.onChanged != null) {
          widget.onChanged!(getSelectedDateString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
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
          getSelectedDateString(),
          style: TextStyle(
            color: widget.textColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
