import 'package:charts_flutter/flutter.dart' as charts hide TextStyle;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/modules/graficos_opinioes/controller.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/aviso.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/card_filtro.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/card_grafico.dart';
import 'package:healthbox/app/modules/graficos_opinioes/widgets/loading.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class GraficoBarraHorizontalPage extends GetView<GraficosOpinioesController> {
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
        labelAccessorFn: (Grafico row, _) => '${row.label}',
      )
    ];
    return Scaffold(
      backgroundColor: corPrincipal100,
      appBar: AppBar(
        title: Text(controller.tituloAppBar),
      ),
      body: Obx(
        () => SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: controller.carregando
                ? const Loading()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CardFiltro(),
                      CardGrafico(
                          grafico: charts.BarChart(
                        seriesgrafico,
                        animate: true,
                        vertical: false,
                        barRendererDecorator:
                            charts.BarLabelDecorator<String>(),
                        domainAxis: const charts.OrdinalAxisSpec(),
                      )),
                      const Aviso()
                    ],
                  )),
      ),
    );
  }
}
