import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/graficos_opinioes/controller.dart';

class CardGrafico extends GetView<GraficosOpinioesController> {
  dynamic grafico;

  CardGrafico({required this.grafico, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: Get.rawRoute!.settings.name == '/graficos-opinioes/pie'
                ? MediaQuery.of(context).size.height * 0.7
                : controller.graficos.isNotEmpty
                    ? MediaQuery.of(context).size.height *
                        (controller.graficos.length * 0.1)
                    : 50,
            padding: const EdgeInsets.all(5),
            child: Center(
              child: controller.graficos.isNotEmpty
                  ? grafico
                  : const Text(
                      'Use o filtro acima para escolher os medicamentos',
                      style: TextStyle(color: Colors.black),
                    ),
            ),
          ),
        ));
  }
}
