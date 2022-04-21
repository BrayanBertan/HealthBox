import 'package:charts_flutter/flutter.dart' as charts hide TextStyle;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/modules/graficos_opinioes/controller.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/aviso.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/card_filtro.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/card_grafico.dart';
import 'package:healthbox/app/widgets/loading.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class GraficoPiePage extends GetView<GraficosOpinioesController> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Grafico, String>> seriesgrafico = [
      charts.Series<Grafico, String>(
        id: 'graficoId',
        colorFn: (Grafico segment, __) =>
            controller.getGraficosColor(segment.id),
        domainFn: (Grafico series, _) => series.eixoX,
        measureFn: (Grafico series, _) => series.eixoY,
        data: controller.graficos,
        labelAccessorFn: (Grafico row, _) => '${row.eixoY}%:${row.eixoX}',
      )
    ];
    return Scaffold(
      backgroundColor: corPrincipal100,
      appBar: AppBar(
        title: Text(controller.tituloAppBar),
      ),
      body: Obx(() => SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: controller.carregando
              ? const Loading()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CardFiltro(),
                    CardGrafico(
                        grafico: charts.PieChart(seriesgrafico,
                            animate: true,
                            selectionModels: [
                              charts.SelectionModelConfig<String>(
                                type: charts.SelectionModelType.info,
                                changedListener: (model) {
                                  if (model.selectedDatum.isEmpty) return;
                                  int index = model.selectedDatum.first.index!;
                                  EasyLoading.instance.backgroundColor =
                                      controller.getGraficosColor(
                                          controller.graficos[index].id,
                                          tipo: 1);
                                  EasyLoading.showToast(
                                      '${controller.graficos[index].eixoX} é fabricado por ${controller.graficos[index].label}',
                                      toastPosition:
                                          EasyLoadingToastPosition.bottom,
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      dismissOnTap: true);
                                },
                                updatedListener: (model) {},
                              ),
                            ],
                            defaultRenderer: charts.ArcRendererConfig<String>(
                                arcRendererDecorators: [
                                  charts.ArcLabelDecorator(
                                      labelPosition:
                                          charts.ArcLabelPosition.auto)
                                ]))),
                    const Aviso()
                  ],
                ))),
    );
  }
}
