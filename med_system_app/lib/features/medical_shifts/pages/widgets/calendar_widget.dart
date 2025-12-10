import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDaySelected;
  final Function(int month, int year)? onMonthChanged;
  final int initialMonth;
  final int initialYear;
  final List<MedicalShiftEntity> events;

  const CalendarWidget({
    super.key,
    required this.onDaySelected,
    required this.onMonthChanged,
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

  List<MedicalShiftEntity> getEventsForDay(DateTime day) {
    List<MedicalShiftEntity> eventsForDay = [];
    for (var event in widget.events) {
      if (event.date == null || event.date!.isEmpty) continue;
      try {
        DateTime eventDate = DateFormat('dd/MM/yyyy').parse(event.date!);
        if (eventDate.year == day.year &&
            eventDate.month == day.month &&
            eventDate.day == day.day) {
          eventsForDay.add(event);
        }
      } catch (e) {
        // ignore error
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
                  key: ValueKey(widget.events.length),
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
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });

                    widget.onMonthChanged
                        ?.call(focusedDay.month, focusedDay.year);
                  },
                  availableGestures: AvailableGestures.none,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronVisible: true,
                    rightChevronVisible: true,
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
                      List<MedicalShiftEntity> dayEvents = getEventsForDay(day);
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
