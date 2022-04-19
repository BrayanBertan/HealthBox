import 'package:charts_flutter/flutter.dart' as charts hide TextStyle;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/modules/graficos_opinioes/controller.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/aviso.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class GraficoBarraEficaciaPage extends GetView<GraficosOpinioesController> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Grafico, String>> seriesgrafico = [
      charts.Series<Grafico, String>(
        id: 'graficoId',
        colorFn: (Grafico segment, __) {
          switch (segment.id) {
            case 0:
              return charts.MaterialPalette.green.shadeDefault;
            case 1:
              return charts.MaterialPalette.yellow.shadeDefault;
            case 2:
              return charts.MaterialPalette.red.shadeDefault;
            case 3:
              return charts.MaterialPalette.blue.shadeDefault;
            case 4:
              return charts.MaterialPalette.purple.shadeDefault;
            case 5:
              return charts.MaterialPalette.pink.shadeDefault;
            case 6:
              return charts.MaterialPalette.gray.shadeDefault;
            case 7:
              return charts.MaterialPalette.cyan.shadeDefault;
            case 8:
              return charts.MaterialPalette.deepOrange.shadeDefault;
            case 9:
              return charts.MaterialPalette.lime.shadeDefault;
            default:
              return charts.MaterialPalette.indigo.shadeDefault;
          }
        },
        domainFn: (Grafico series, _) => series.eixoX,
        measureFn: (Grafico series, _) => series.eixoY.toDouble(),
        data: controller.graficos,
        labelAccessorFn: (Grafico row, _) => 'Eficaz',
      ),
      charts.Series<Grafico, String>(
        id: 'graficdoId',
        colorFn: (Grafico segment, __) {
          switch (segment.id) {
            case 0:
              return charts.MaterialPalette.green.shadeDefault.lighter;
            case 1:
              return charts.MaterialPalette.yellow.shadeDefault.lighter;
            case 2:
              return charts.MaterialPalette.red.shadeDefault.lighter;
            case 3:
              return charts.MaterialPalette.blue.shadeDefault.lighter;
            case 4:
              return charts.MaterialPalette.purple.shadeDefault.lighter;
            case 5:
              return charts.MaterialPalette.pink.shadeDefault.lighter;
            case 6:
              return charts.MaterialPalette.gray.shadeDefault.lighter;
            case 7:
              return charts.MaterialPalette.cyan.shadeDefault.lighter;
            case 8:
              return charts.MaterialPalette.deepOrange.shadeDefault.lighter;
            case 9:
              return charts.MaterialPalette.lime.shadeDefault;
            default:
              return charts.MaterialPalette.indigo.shadeDefault;
          }
        },
        domainFn: (Grafico series, _) => series.eixoX,
        measureFn: (Grafico series, _) => series.eixoY.toDouble(),
        data: controller.graficos,
        labelAccessorFn: (Grafico row, _) => 'Ineficaz',
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
                          (controller.graficos.length * 0.08),
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: controller.carregando
                            ? CircularProgressIndicator(
                                color: corPrincipal,
                              )
                            : controller.graficos.isNotEmpty
                                ? charts.BarChart(
                                    seriesgrafico,
                                    barGroupingType:
                                        charts.BarGroupingType.grouped,
                                    animate: true,
                                    vertical: false,
                                    barRendererDecorator:
                                        charts.BarLabelDecorator<String>(),
                                    domainAxis: const charts.OrdinalAxisSpec(),
                                  )
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
