import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_mobx/flutter_mobx.dart'; // Importando o Observer do MobX

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDaySelected;
  final int initialMonth;
  final int initialYear;
  final List<EventProcedures> events; // Passando a lista de eventos

  const CalendarWidget({
    Key? key,
    required this.onDaySelected,
    required this.initialMonth,
    required this.initialYear,
    required this.events, // Lista de eventos
  }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime(widget.initialYear, widget.initialMonth);
    _selectedDay = DateTime.now();
  }

  // Função para filtrar eventos para o dia selecionado
  List<EventProcedures> getEventsForDay(DateTime day) {
    List<EventProcedures> eventsForDay = [];
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
              // Calendário
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
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
                    // Passando o dia selecionado com ano e mês
                    widget.onDaySelected(DateTime(selectedDate.year,
                        selectedDate.month, selectedDate.day));
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  availableGestures: AvailableGestures.none,
                  headerStyle: HeaderStyle(
                    titleCentered: true, // Centralizar o título
                    formatButtonVisible:
                        false, // Remover botão de troca de formato
                    leftChevronVisible: false, // Remover seta esquerda
                    rightChevronVisible: false, // Remover seta direita
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .primaryColor, // Usar cor primária do tema
                    ),
                    titleTextFormatter: (date, locale) => DateFormat.yMMM(
                            locale)
                        .format(date)
                        .capitalize(), // Adiciona a capitalização da primeira letra
                  ),
                  calendarBuilders: CalendarBuilders(
                    // Customizar o dia do mês com um marker (círculo, ícone, etc.)
                    markerBuilder: (context, day, events) {
                      List<EventProcedures> dayEvents = getEventsForDay(day);
                      if (dayEvents.isNotEmpty) {
                        return Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red, // Cor do marker
                              shape: BoxShape.circle,
                            ),
                            child: dayEvents.length > 1
                                ? Text(
                                    '${dayEvents.length}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null, // Se tiver mais de 1 evento, mostra a quantidade
                          ),
                        );
                      }
                      return const SizedBox(); // Caso não tenha evento
                    },
                  ),
                  locale:
                      'pt_BR', // Definindo o calendário para o idioma português
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
  // Função para capitalizar a primeira letra
  String capitalize() {
    if (this.isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}
