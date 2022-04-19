import 'package:charts_flutter/flutter.dart' as charts hide TextStyle;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/modules/graficos_opinioes/controller.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/aviso.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class GraficoPiePage extends GetView<GraficosOpinioesController> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Grafico, String>> seriesgrafico = [
      charts.Series<Grafico, String>(
        id: 'graficoId',
        colorFn: (Grafico segment, __) =>
            controller.getGraficosColor(segment.id),
        domainFn: (Grafico series, _) => series.eixoX,
        measureFn: (Grafico series, _) => series.eixoY.toDouble(),
        data: controller.graficos,
        labelAccessorFn: (Grafico row, _) => '${row.eixoY}%:${row.eixoX}',
      )
    ];
    return Scaffold(
      backgroundColor: corPrincipal100,
      appBar: AppBar(
        title: Text(controller.tituloAppBar),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: MultiSelectChipField<Medicamento?>(
                    initialValue: controller.medicamentosSelecionados,
                    title: const Text('Medicamentos'),
                    searchable: true,
                    height: 50,
                    searchHint: 'Pesquisar',
                    onTap: (itens) {},
                    items: controller.medicamentos
                        .map((medicamento) => MultiSelectItem<Medicamento?>(
                            medicamento, medicamento.nome))
                        .toList()),
              ),
              Obx(() => Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height *
                          (controller.graficos.length * 0.075),
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: controller.carregando
                            ? CircularProgressIndicator(
                                color: corPrincipal,
                              )
                            : controller.graficos.isNotEmpty
                                ? charts.PieChart(seriesgrafico,
                                    animate: true,
                                    selectionModels: [
                                      charts.SelectionModelConfig<String>(
                                        type: charts.SelectionModelType.info,
                                        changedListener: (model) {
                                          int index =
                                              model.selectedDatum.first.index!;
                                          EasyLoading.instance.backgroundColor =
                                              controller.getGraficosColor(
                                                  controller.graficos[index].id,
                                                  tipo: 1);
                                          EasyLoading.showToast(
                                              '${controller.graficos[index].eixoX} é fabricado por ${controller.graficos[index].label}',
                                              toastPosition:
                                                  EasyLoadingToastPosition
                                                      .bottom,
                                              duration: const Duration(
                                                  milliseconds: 1000));
                                        },
                                        updatedListener: (model) {},
                                      ),
                                    ],
                                    defaultRenderer:
                                        charts.ArcRendererConfig<String>(
                                            arcRendererDecorators: [
                                          charts.ArcLabelDecorator(
                                              labelPosition:
                                                  charts.ArcLabelPosition.auto)
                                        ]))
                                : const Text(
                                    'Sem dados para esses medicamentos'),
                      ),
                    ),
                  )),
              const Aviso()
            ],
          )),
    );
  }
}
