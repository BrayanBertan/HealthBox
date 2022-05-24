import 'package:charts_flutter/flutter.dart' as charts hide TextStyle;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
import 'package:healthbox/app/modules/graficos/controller.dart';
import 'package:healthbox/app/modules/graficos/widgets/aviso.dart';
import 'package:healthbox/app/modules/graficos/widgets/card_grafico.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/shimmer_select.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/tile_dropdown_vinculo.dart';
import 'package:healthbox/app/widgets/notificacoes/custom_appbar.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class GraficoPieRespostaPage extends GetView<GraficosOpinioesController> {
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
      appBar: CustomAppBar(
        title: controller.tituloAppBar,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => controller.carregandoMedicamentos
                    ? const ShimmerSelects()
                    : controller.vinculos.isEmpty
                        ? const Text('Sem pacientes disponiveis')
                        : DropdownSearch<Vinculo>(
                            mode: Mode.DIALOG,
                            dropdownSearchDecoration: const InputDecoration(
                              labelText: 'Selecionar o paciente',
                              isDense: true,
                            ),
                            dropDownButton: Container(),
                            items: controller.vinculos,
                            dropdownButtonBuilder: null,
                            dropdownBuilder: (_, vinculo) =>
                                controller.vinculo == null
                                    ? const Text('')
                                    : TileDropDownVinculo(
                                        vinculo: controller.vinculo),
                            popupItemBuilder: (_, vinculo, __) =>
                                TileDropDownVinculo(vinculo: vinculo),
                            showSearchBox: true,
                            emptyBuilder: (_, __) => const Center(
                              child: Text(
                                'Nenhum paciente foi encontrado.Use o campo de pesquisa acima.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            showClearButton: true,
                            onChanged: (Vinculo? vinculo) =>
                                controller.vinculo = vinculo,
                          ),
              ),
              const SizedBox(
                height: 15,
              ),
              CardGrafico(
                  grafico: charts.PieChart(seriesgrafico,
                      animate: true,
                      selectionModels: [
                        charts.SelectionModelConfig<String>(
                          type: charts.SelectionModelType.info,
                          changedListener: (model) {
                            if (model.selectedDatum.isEmpty) return;
                            int index = model.selectedDatum.first.index!;
                            EasyLoading.instance.backgroundColor = controller
                                .getGraficosColor(controller.graficos[index].id,
                                    tipo: 1);
                            EasyLoading.showToast(
                                '${controller.graficos[index].eixoY}% ${controller.graficos[index].eixoX} ',
                                toastPosition: EasyLoadingToastPosition.bottom,
                                duration: const Duration(milliseconds: 2000),
                                dismissOnTap: true);
                          },
                          updatedListener: (model) {},
                        ),
                      ],
                      defaultRenderer: charts.ArcRendererConfig<String>(
                          arcRendererDecorators: [
                            charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.auto)
                          ]))),
              controller.usuario.tipo == TipoUsuario.PACIENTE
                  ? const Aviso()
                  : Container()
            ],
          )),
    );
  }
}
