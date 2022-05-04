import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/questionario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/table_calendar_view/widgets/table_calendar_builders.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarBuilder extends GetView<AcompanhamentosController> {
  const TableCalendarBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => TableCalendar<Questionario>(
            locale: 'pt_BR',
            eventLoader: (data) =>
                controller
                    .questionarios[DateTime(data.year, data.month, data.day)] ??
                <Questionario>[],
            selectedDayPredicate: (date) =>
                DateTime(date.year, date.month, date.day) ==
                controller.diaSelecionado,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (_, data, proximoDia) => TableCalendarBuilders(
                  textStyle: const TextStyle(color: Colors.black),
                  itemValue: data.day,
                  boxDecoration: const BoxDecoration(color: Colors.transparent),
                  width: 35.0,
                  height: 35.0),
              outsideBuilder: (_, data, proximoDia) => TableCalendarBuilders(
                  textStyle: const TextStyle(color: Colors.grey),
                  itemValue: data.day,
                  boxDecoration: const BoxDecoration(color: Colors.transparent),
                  width: 35.0,
                  height: 35.0),
              selectedBuilder: (_, data, proximoDia) => TableCalendarBuilders(
                  textStyle: const TextStyle(color: Colors.white),
                  itemValue: data.day,
                  boxDecoration: BoxDecoration(
                      shape: BoxShape.circle, color: corPrincipal),
                  width: 35.0,
                  height: 35.0),
              todayBuilder: (_, data, proximoDia) => TableCalendarBuilders(
                  textStyle: TextStyle(
                      color: corPrincipal, fontWeight: FontWeight.bold),
                  itemValue: data.day,
                  boxDecoration: const BoxDecoration(color: Colors.transparent),
                  width: 35.0,
                  height: 35.0),
              markerBuilder: (context, day, events) => Positioned(
                  right: 1,
                  bottom: 1,
                  child: events.isEmpty
                      ? Container()
                      : TableCalendarBuilders(
                          textStyle: const TextStyle(color: Colors.white),
                          itemValue: events.length,
                          boxDecoration: BoxDecoration(
                              shape: BoxShape.circle, color: corPrincipal),
                          width: 16.0,
                          height: 16.0)),
            ),
            onFormatChanged: controller.setCalendarFormat,
            onDaySelected: (date, date1) =>
                controller.setQuestionariosDia(date),
            calendarFormat: controller.calendarFormat,
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
              todayTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
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
          ),
        ),
      ),
    );
  }
}
