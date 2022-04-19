import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/data/repositories/grafico.dart';

class GraficosOpinioesController extends GetxController {
  final GraficoRepository repository;

  GraficosOpinioesController({required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    getGraficos();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  final graficos = <Grafico>[].obs;
  final medicamentos = <Medicamento>[].obs;
  final medicamentosSelecionados = <Medicamento>[].obs;
  final _carregando = false.obs;

  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;

  getGraficos() {
    carregando = true;
    repository.getGraficos(medicamentos: '').then((retorno) {
      graficos.clear();
      graficos.assignAll(retorno);
      carregando = false;
    });
  }

  final tiposDeGraficos = <Map<String, dynamic>>[
    {
      'titulo': 'Remédio x Quantidade de uso',
      'imagem': 'bar-chart.png',
      'tipo': 0
    },
    {
      'titulo': 'Remédio x Porcentagem de uso',
      'imagem': 'pie-chart.png',
      'tipo': 1
    },
    {
      'titulo': 'Remédio x Quantidade de uso por trimestre',
      'imagem': 'line-chart.png',
      'tipo': 2
    },
    {
      'titulo': 'Remédio x Eficaz x Ineficaz',
      'imagem': 'double-bar-chart.png',
      'tipo': 3
    },
  ];

  @override
  void onClose() {}
}
