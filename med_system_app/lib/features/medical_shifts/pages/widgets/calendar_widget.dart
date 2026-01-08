import 'package:distrito_medico/features/medical_shifts/model/medical_shift.model.dart';
import 'package:distrito_medico/core/utils/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDaySelected;
  final Function(int month, int year)? onMonthChanged;
  final int initialMonth;
  final int initialYear;
  final List<MedicalShiftModel> events;

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
                      List<MedicalShiftModel> dayEvents = getEventsForDay(day);
                      if (dayEvents.isEmpty) {
                        return const SizedBox();
                      }

                      // Se houver apenas um plantão, mostra um círculo com a cor
                      if (dayEvents.length == 1) {
                        return Positioned(
                          bottom: 1,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: ColorHelper.hexToColor(
                                dayEvents[0].color,
                                defaultColor: ColorHelper.defaultMedicalShiftColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }

                      // Se houver múltiplos plantões, mostra múltiplos pontos coloridos
                      return Positioned(
                        bottom: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: dayEvents.take(3).map((shift) {
                            return Container(
                              width: 5,
                              height: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: ColorHelper.hexToColor(
                                  shift.color,
                                  defaultColor: ColorHelper.defaultMedicalShiftColor,
                                ),
                                shape: BoxShape.circle,
                              ),
                            );
                          }).toList(),
                        ),
                      );
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
