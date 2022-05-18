import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/graficos/controller.dart';
import 'package:healthbox/app/widgets/shimmer_graficos.dart';
import 'package:healthbox/routes/app_pages.dart';

class CardGrafico extends GetView<GraficosOpinioesController> {
  dynamic grafico;
  CardGrafico({required this.grafico, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.carregando
        ? const ShimmerContainer()
        : Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: Get.currentRoute == Routes.GRAFICO_MELHORA
                  ? controller.graficosMedico.isNotEmpty
                      ? MediaQuery.of(context).size.height *
                          (controller.graficosMedico.length * 0.15)
                      : 50
                  : Get.currentRoute == Routes.GRAFICO_PIE ||
                          Get.currentRoute == Routes.GRAFICO_RESPOSTA
                      ? MediaQuery.of(context).size.height * 0.7
                      : controller.graficos.isNotEmpty
                          ? MediaQuery.of(context).size.height *
                              (controller.graficos.length * 0.10)
                          : 50,
              padding: const EdgeInsets.all(5),
              child: Center(
                child: controller.graficos.isNotEmpty ||
                        controller.graficosMedico.isNotEmpty
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
