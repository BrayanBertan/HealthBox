import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/table_calendar_view/widgets/list_questionarios_calendar.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/table_calendar_view/widgets/table_calendar_builder.dart';
import 'package:healthbox/app/modules/graficos/widgets/shimmer_graficos.dart';

class TableCalendarPage extends GetView<AcompanhamentosController> {
  const TableCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Obx(
          () => controller.carregando
              ? const ShimmerGraficos()
              : TableCalendarBuilder(),
        ),
        ListQuestionariosCalendar(),
      ],
    ));
  }
}
