import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/data/repositories/grafico.dart';
import 'package:healthbox/core/theme/easy_loading_config.dart';
import 'package:healthbox/routes/app_pages.dart';

class GraficosOpinioesController extends GetxController {
  final GraficoRepository repository;

  GraficosOpinioesController({required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    interval(_medicamentosId, (val) async {
      getGraficos();
    }, time: const Duration(milliseconds: 100));
  }

  @override
  void onReady() {
    super.onReady();
  }

  final graficos = <Grafico>[].obs;
  final graficosTemp = <Grafico>[].obs;
  final medicamentos = <Medicamento>[
    Medicamento(id: 1, nome: 'Eficentus', fabricante: '', bula: ''),
    Medicamento(id: 2, nome: 'Dipirona', fabricante: '', bula: ''),
    Medicamento(id: 3, nome: 'BENEGRIP', fabricante: '', bula: ''),
  ].obs;
  final medicamentosSelecionados = List<Medicamento>.empty().obs;
  final _carregando = false.obs;
  String tituloAppBar = '';
  String endpoint = '';
  final _medicamentosId = ''.obs;
  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;
  get medicamentosId => this._medicamentosId.value;
  set medicamentosId(value) => this._medicamentosId.value = value;

  setMedicamentos(items) {
    medicamentosSelecionados.clear();
    medicamentosId = '';
    if (items.isEmpty) return;
    items.forEach((element) => medicamentosSelecionados.add(element!));
    medicamentosSelecionados
        .forEach((element) => medicamentosId += '${element.id},');
    medicamentosId = medicamentosId.substring(0, medicamentosId.length - 1);
  }

  getGraficos() {
    carregando = true;
    endpoint = endpoint.split('remedios')[0];
    if (medicamentosId.isNotEmpty) {
      endpoint += 'remedios=$medicamentosId';
    }
    repository.getGraficos(endpoint: endpoint).then((List<Grafico> retorno) {
      graficos.clear();
      graficos.assignAll(retorno);

      carregando = false;
    });
  }

  getGraficosColor(int id, {int tipo = 0}) {
    if (tipo == 0) {
      switch (id) {
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
    } else {
      switch (id) {
        case 0:
          return Colors.green;
        case 1:
          return Colors.yellow;
        case 2:
          return Colors.red;
        case 3:
          return Colors.blue;
        case 4:
          return Colors.purple;
        case 5:
          return Colors.pink;
        case 6:
          return Colors.grey;
        case 7:
          return Colors.cyan;
        case 8:
          return Colors.deepOrange;
        case 9:
          return Colors.lime;
        default:
          return Colors.indigo;
      }
    }
  }

  final tiposDeGraficos = <Map<String, dynamic>>[
    {
      'titulo': 'Remédio x Quantidade de pacientes usando',
      'imagem': 'bar-chart.png',
      'page': Routes.GRAFICO_BARRA,
      'endpoint': 'paciente-remedio?'
    },
    {
      'titulo': 'Remédio x Porcentagem de uso',
      'imagem': 'pie-chart.png',
      'page': Routes.GRAFICO_PIE,
      'endpoint': 'paciente-remedio?tipoGrafico=pie&'
    },
    {
      'titulo': 'Remédio x Quantidade de uso por data',
      'imagem': 'line-chart.png',
      'page': Routes.GRAFICO_LINES,
      'endpoint': 'paciente-remedio?'
    },
    {
      'titulo': 'Remédio x Eficaz x Ineficaz',
      'imagem': 'double-bar-chart.png',
      'page': Routes.GRAFICO_BARRA_EFICACIA,
      'endpoint': 'remedio-eficacia?'
    },
  ];

  @override
  void onClose() {
    EasyLoadingConfig();
  }
}
