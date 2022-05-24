import 'package:charts_flutter/flutter.dart' as charts hide TextStyle;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/grafico_medico.dart';
import 'package:healthbox/app/modules/graficos/controller.dart';
import 'package:healthbox/app/modules/graficos/widgets/aviso.dart';
import 'package:healthbox/app/modules/graficos/widgets/card_filtro.dart';
import 'package:healthbox/app/modules/graficos/widgets/card_grafico.dart';
import 'package:healthbox/app/widgets/notificacoes/custom_appbar.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class GraficoBarraMelhoraPage extends GetView<GraficosOpinioesController> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<GraficoMedico, String>> seriesgrafico = [
      charts.Series<GraficoMedico, String>(
        id: 'graficoMelhora',
        colorFn: (GraficoMedico segment, __) {
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
        domainFn: (GraficoMedico series, _) => series.eixoX,
        measureFn: (GraficoMedico series, _) => series.eixoYMelhorou,
        data: controller.graficosMedico,
        labelAccessorFn: (GraficoMedico row, _) => 'Melhor',
      ),
      charts.Series<GraficoMedico, String>(
        id: 'graficoIgual',
        colorFn: (GraficoMedico segment, __) {
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
        domainFn: (GraficoMedico series, _) => series.eixoX,
        measureFn: (GraficoMedico series, _) => series.eixoYigual,
        data: controller.graficosMedico,
        labelAccessorFn: (GraficoMedico row, _) => 'Igual',
      ),
      charts.Series<GraficoMedico, String>(
        id: 'graficoIgual',
        colorFn: (GraficoMedico segment, __) {
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
        domainFn: (GraficoMedico series, _) => series.eixoX,
        measureFn: (GraficoMedico series, _) => series.eixoYPiorou,
        data: controller.graficosMedico,
        labelAccessorFn: (GraficoMedico row, _) => 'Pior',
      )
    ];
    return Scaffold(
      backgroundColor: corPrincipal100,
      appBar: CustomAppBar(
        title: controller.tituloAppBar,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CardFiltro(),
              CardGrafico(
                  grafico: charts.BarChart(
                seriesgrafico,
                barGroupingType: charts.BarGroupingType.grouped,
                animate: true,
                vertical: false,
                selectionModels: [
                  charts.SelectionModelConfig<String>(
                    type: charts.SelectionModelType.info,
                    changedListener: (model) {
                      if (model.selectedDatum.isEmpty) return;
                      int index = model.selectedDatum.first.index!;
                      EasyLoading.instance.backgroundColor = controller
                          .getGraficosColor(controller.graficosMedico[index].id,
                              tipo: 1);
                      EasyLoading.showToast(
                          '${controller.graficosMedico[index].eixoX} é fabricado por ${controller.graficosMedico[index].eixoX}',
                          toastPosition: EasyLoadingToastPosition.bottom,
                          duration: const Duration(milliseconds: 2000),
                          dismissOnTap: true);
                    },
                    updatedListener: (model) {},
                  ),
                ],
                barRendererDecorator: charts.BarLabelDecorator<String>(),
                domainAxis: const charts.OrdinalAxisSpec(),
              )),
              controller.usuario.tipo == TipoUsuario.PACIENTE
                  ? const Aviso()
                  : Container()
            ],
          )),
    );
  }
}
