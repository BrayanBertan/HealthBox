import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarPage extends StatelessWidget {
  const TableCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TableCalendar(
      locale: 'pt_BR',
      calendarFormat: CalendarFormat.twoWeeks,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Mês',
        CalendarFormat.week: 'Semana',
        CalendarFormat.twoWeeks: '2 semanas',
      },
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        markerDecoration: BoxDecoration(color: corPrincipal),
        selectedDecoration:
            BoxDecoration(color: corPrincipal, shape: BoxShape.circle),
        todayTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            const TextStyle(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: corPrincipal,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
    ));
  }
}
