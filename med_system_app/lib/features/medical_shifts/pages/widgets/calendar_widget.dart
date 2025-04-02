import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDaySelected;
  final int initialMonth;
  final int initialYear;
  final List<MedicalShiftModel> events;

  const CalendarWidget({
    super.key,
    required this.onDaySelected,
    required this.initialMonth,
    required this.initialYear,
    required this.events,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    setState(() {});
    _focusedDay = DateTime(widget.initialYear, widget.initialMonth);
    _selectedDay = DateTime.now();
  }

  List<MedicalShiftModel> getEventsForDay(DateTime day) {
    List<MedicalShiftModel> eventsForDay = [];
    for (var event in widget.events) {
      DateTime eventDate = DateFormat('dd/MM/yyyy').parse(event.date ?? '');
      if (eventDate.year == day.year &&
          eventDate.month == day.month &&
          eventDate.day == day.day) {
        eventsForDay.add(event);
      }
    }
    return eventsForDay;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDate, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDate;
                      _focusedDay = focusedDay;
                    });

                    widget.onDaySelected(DateTime(selectedDate.year,
                        selectedDate.month, selectedDate.day));
                  },
                  onFormatChanged: (format) {
                    setState(() {});
                  },
                  availableGestures: AvailableGestures.none,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronVisible: false,
                    rightChevronVisible: false,
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    titleTextFormatter: (date, locale) =>
                        DateFormat.yMMM(locale).format(date).capitalize(),
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8)),
                    todayDecoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8)),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape
                          .rectangle, // Define um padrão para evitar conflitos
                      borderRadius: BorderRadius.circular(8),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      List<MedicalShiftModel> dayEvents = getEventsForDay(day);
                      if (dayEvents.isNotEmpty) {
                        return Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: dayEvents.length > 1
                                ? Text(
                                    '${dayEvents.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  locale: 'pt_BR',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
