import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/data/models/grafico_medico.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
import 'package:healthbox/app/data/providers/conta.dart';
import 'package:healthbox/app/data/repositories/conta.dart';
import 'package:healthbox/app/data/repositories/grafico.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/core/theme/easy_loading_config.dart';
import 'package:healthbox/routes/app_pages.dart';

class GraficosOpinioesController extends GetxController {
  final GraficoRepository repository;

  GraficosOpinioesController({required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    usuario = Get.find<LoginController>().getLogin();
    if (usuario.tipo == TipoUsuario.PACIENTE) {
      tiposDeGraficos.assignAll(tiposDeGraficosPaciente);
    } else {
      getVinculos();
      tiposDeGraficos.assignAll(tiposDeGraficosMedico);
      interval(_vinculo, (val) async {
        getGraficosResposta();
      }, time: const Duration(milliseconds: 250));
    }
    interval(_medicamentosId, (val) async {
      if (usuario.tipo == TipoUsuario.PACIENTE) {
        getGraficos();
      } else {
        getGraficosMedico();
      }
    }, time: const Duration(milliseconds: 250));
    interval(_isExercicioFisicoChecked, (val) async {
      getGraficosMedico();
    }, time: const Duration(milliseconds: 250));
    getMedicamentosUsadosFiltro();
  }

  @override
  void onReady() {
    super.onReady();
  }

  final graficos = <Grafico>[].obs;
  final graficosMedico = <GraficoMedico>[].obs;
  dynamic usuario;
  final vinculos = <Vinculo>[].obs;
  final medicamentos = <Medicamento>[].obs;
  final medicamentosSelecionados = List<Medicamento>.empty().obs;
  final _carregando = false.obs;
  final _carregandoMedicamentos = false.obs;
  final _isExercicioFisicoChecked = false.obs;
  final _vinculo = Rx<Vinculo?>(null);
  String tituloAppBar = '';
  String endpoint = '';

  final _medicamentosId = ''.obs;
  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;
  get medicamentosId => this._medicamentosId.value;
  set medicamentosId(value) => this._medicamentosId.value = value;
  get carregandoMedicamentos => this._carregandoMedicamentos.value;
  set carregandoMedicamentos(value) =>
      this._carregandoMedicamentos.value = value;
  get isExercicioFisicoChecked => this._isExercicioFisicoChecked.value;
  setIsExercicioFisicoChecked(value) =>
      this._isExercicioFisicoChecked.value = value;

  get vinculo => this._vinculo.value;
  set vinculo(value) => this._vinculo.value = value;

  setMedicamentos(items) {
    medicamentosSelecionados.clear();
    medicamentosId = '';
    if (items.length > 5) {
      items = items.take(5);
    }
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

  getGraficosMedico() {
    carregando = true;
    repository
        .getGraficosMedico(medicamentosId, isExercicioFisicoChecked ? 1 : 0)
        .then((List<GraficoMedico> retorno) {
      graficosMedico.clear();
      graficosMedico.assignAll(retorno);

      carregando = false;
    });
  }

  getGraficosResposta() {
    if (vinculo == null) return;
    carregando = true;
    repository
        .getGraficosResposta(vinculo.usuarioId)
        .then((List<Grafico> retorno) {
      graficos.assignAll(retorno);

      carregando = false;
    });
  }

  getMedicamentosUsadosFiltro() {
    carregandoMedicamentos = true;
    String endpoint = '';
    if (usuario.tipo == TipoUsuario.MEDICO) endpoint = '/acompanhamentos';

    repository
        .getMedicamentosUsadosFiltro(endpoint)
        .then((List<Medicamento> retorno) {
      medicamentos.clear();
      medicamentos.assignAll(retorno);

      carregandoMedicamentos = false;
    });
  }

  getVinculos() {
    carregandoMedicamentos = true;
    ContaRepository(provider: ContaProvider()).getVinculos(1).then((retorno) {
      vinculos.clear();
      vinculos.assignAll(retorno);
      carregandoMedicamentos = false;
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

  var tiposDeGraficos = <Map<String, dynamic>>[];
  final tiposDeGraficosPaciente = <Map<String, dynamic>>[
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
      'titulo': 'Remédio x Eficaz x Ineficaz',
      'imagem': 'double-bar-chart.png',
      'page': Routes.GRAFICO_BARRA_EFICACIA,
      'endpoint': 'remedio-eficacia?'
    },
  ];

  final tiposDeGraficosMedico = <Map<String, dynamic>>[
    {
      'titulo': 'Remédio x Melhora x Atividade física',
      'imagem': 'bar-chart.png',
      'page': Routes.GRAFICO_MELHORA,
      'endpoint': 'remedio-melhora?remedios&grafico_exercicio=0/1'
    },
    {
      'titulo': 'Paciente x Respostas',
      'imagem': 'pie-chart.png',
      'page': Routes.GRAFICO_RESPOSTA,
      'endpoint': 'graficos/paciente-resposta?paciente_id='
    },
  ];

  @override
  void onClose() {
    EasyLoadingConfig();
  }
}
