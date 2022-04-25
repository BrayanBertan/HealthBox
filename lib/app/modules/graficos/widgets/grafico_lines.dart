import 'package:charts_flutter/flutter.dart' as charts hide TextStyle;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/graficos/controller.dart';
import 'package:healthbox/app/modules/graficos/widgets/aviso.dart';
import 'package:healthbox/app/modules/graficos/widgets/card_filtro.dart';
import 'package:healthbox/app/modules/graficos/widgets/card_grafico.dart';
import 'package:healthbox/app/widgets/loading.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class GraficoLinesPage extends GetView<GraficosOpinioesController> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Map, DateTime>> seriesgrafico = [
      charts.Series<Map, DateTime>(
        id: 'graficoId',
        colorFn: (Map segment, __) {
          return charts.MaterialPalette.green.shadeDefault;
        },
        domainFn: (Map series, _) => series['titulo'],
        measureFn: (Map series, _) => series['value'],
        data: <Map>[
          {
            'titulo': DateTime.now().subtract(const Duration(days: 3)),
            'value': 5
          },
          {
            'titulo': DateTime.now().subtract(const Duration(days: 6)),
            'value': 10
          },
          {
            'titulo': DateTime.now().subtract(const Duration(days: 12)),
            'value': 15
          },
          {'titulo': DateTime.now().add(const Duration(days: 24)), 'value': 20},
          {'titulo': DateTime.now().add(const Duration(days: 24)), 'value': 20},
          {'titulo': DateTime.now().add(const Duration(days: 48)), 'value': 25},
        ],
      ),
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
                        grafico: charts.TimeSeriesChart(seriesgrafico,
                            animate: true,
                            dateTimeFactory: charts.LocalDateTimeFactory(),
                            primaryMeasureAxis: const charts.NumericAxisSpec(
                                tickProviderSpec:
                                    charts.BasicNumericTickProviderSpec(
                                        desiredTickCount: 10)),
                            domainAxis: const charts.DateTimeAxisSpec(
                                tickFormatterSpec:
                                    charts.AutoDateTimeTickFormatterSpec(
                                        day: charts.TimeFormatterSpec(
                                            format: 'dd/MM',
                                            transitionFormat: 'dd/MM'))))),
                    const Aviso()
                  ],
                ))),
    );
  }
}
