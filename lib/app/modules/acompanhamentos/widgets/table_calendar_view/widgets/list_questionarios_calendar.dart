import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/table_calendar_view/widgets/item_list_questionarios_calendar.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:intl/intl.dart';

class ListQuestionariosCalendar extends GetView<AcompanhamentosController> {
  const ListQuestionariosCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => Text(
              DateFormat('dd/MM/yyyy').format(controller.diaSelecionado),
              style: subTitulo,
              textAlign: TextAlign.center,
            )),
        Obx(
          () => controller.questionariosSelecionados.isEmpty
              ? const Text(
                  'Nenhum questionário foi encontrado para essa data...',
                  textAlign: TextAlign.center,
                )
              : Scrollbar(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: controller.questionariosSelecionados.length,
                      itemBuilder: (context, index) =>
                          ItemListQuestionariosCalendar(
                            index: index,
                          )),
                ),
        ),
      ],
    ));
  }
}
