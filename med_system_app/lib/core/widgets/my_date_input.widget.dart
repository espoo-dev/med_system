import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInputDate extends StatefulWidget {
  String? label;
  final Color? labelStyleColor;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final DateTime? selectedDate; // Changed to final
  final Function? onChanged;    // Changed to final

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
  DateTime? _internalSelectedDate;

  @override
  void initState() {
    super.initState();
    _internalSelectedDate = widget.selectedDate;
    
    // Call onChanged if we have an initial date to ensure parent is notified
    if (_internalSelectedDate != null && widget.onChanged != null) {
      // Use WidgetsBinding to call after build is complete
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChanged!(getSelectedDateString());
      });
    }
  }

  @override
  void didUpdateWidget(MyInputDate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _internalSelectedDate = widget.selectedDate;
    }
  }

  String getSelectedDateString() {
    if (_internalSelectedDate == null) return '';

    String day = _internalSelectedDate!.day.toString().padLeft(2, '0'); // Pad left for better formatting
    String month = _internalSelectedDate!.month.toString().padLeft(2, '0');
    String year = _internalSelectedDate!.year.toString();

    return '$day/$month/$year';
  }

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme.copyWith(
        primary: Theme.of(context).colorScheme.primary,
        onPrimary: Colors.white,
        onBackground: Colors.white,
        surfaceTint: Colors.white);
    final date = await showDatePicker(
      context: context,
      helpText: 'Selecione a data',
      locale: const Locale('pt', 'BR'),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: _internalSelectedDate ??
          DateTime(DateTime.now().year, DateTime.now().month, 1),
      firstDate: DateTime(2001),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(colorScheme: colorScheme),
          child: child ?? Container(),
        );
      },
    );

    if (date != null) {
      setState(() {
        _internalSelectedDate = date;
      });
      if (widget.onChanged != null) {
        // Construct string manually to match getSelectedDateString but simpler or use same helper?
        // Using helper method on internal state:
        widget.onChanged!(getSelectedDateString());
      }
    }
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
