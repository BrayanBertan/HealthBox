import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/table_calendar_view/widgets/list_questionarios_calendar.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/table_calendar_view/widgets/table_calendar_builder.dart';
import 'package:healthbox/app/widgets/shimmer_graficos.dart';
import 'package:healthbox/app/widgets/shimmer_listagem_simples.dart';

class TableCalendarPage extends GetView<AcompanhamentosController> {
  const TableCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => controller.carregando
              ? const ShimmerContainer()
              : TableCalendarBuilder(),
        ),
        Obx(() => controller.carregando
            ? const ShimmerListagemSimples()
            : ListQuestionariosCalendar()),
      ],
    ));
  }
}
