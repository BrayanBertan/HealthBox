import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/grid_usuarios_acompanhamentos.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/table_calendar_view/view.dart';

import 'header_filtros.dart';

class CardUsuariosAcompanhamentos extends GetView<AcompanhamentosController> {
  const CardUsuariosAcompanhamentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderFiltro(),
            const Divider(),
            Obx(
              () => controller.tipoVisualizacao == 1
                  ? GridUsuariosAcompanhamentos()
                  : TableCalendarPage(),
            ),
          ],
        ),
      ),
    );
  }
}
