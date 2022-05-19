import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/data/models/grafico_medico.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/core/values/keys.dart';

class GraficoProvider extends GetConnect {
  static String token = '';
  @override
  void onInit() {
    //httpClient.defaultDecoder = Usuario.listFromJson;
    httpClient.baseUrl = baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    token = UsuarioProvider.token;

    super.onInit();
  }

  Future<List<Grafico>> getGraficos({required String endpoint}) async {
    Get.find<UsuarioProvider>().isSessionValid();
    try {
      var retornoApi = await get('graficos/$endpoint',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Grafico.listFromJson(obj));

      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Grafico>.empty();
      }
    } catch (erro) {
      print('Erro getGraficos $erro');
      return List<Grafico>.empty();
    }
  }

  Future<List<GraficoMedico>> getGraficosMedico(
      String remedios, int tipo) async {
    Get.find<UsuarioProvider>().isSessionValid();

    try {
      var retornoApi = await get(
          'graficos/remedio-melhora?remedios=$remedios&grafico_exercicio=$tipo',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => GraficoMedico.listFromJson(obj));

      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<GraficoMedico>.empty();
      }
    } catch (erro) {
      print('Erro getGraficosMedico $erro');
      return List<GraficoMedico>.empty();
    }
  }

  Future<List<Grafico>> getGraficosResposta(int idPaciente) async {
    Get.find<UsuarioProvider>().isSessionValid();

    try {
      var retornoApi = await get(
        'graficos/paciente-resposta?paciente_id=$idPaciente',
        headers: {'Authorization': 'Bearer  $token'},
      );
      List<Grafico> graficos = [];

      if (retornoApi.body is String || retornoApi.body.isEmpty)
        return List<Grafico>.empty();
      List grafico = retornoApi.body;
      graficos.assignAll([
        Grafico(
            id: 1,
            eixoX: 'Pendentes',
            eixoY: grafico[0]['pendentes'].toDouble(),
            label: ''),
        Grafico(
            id: 0,
            eixoX: 'Respondidos',
            eixoY: grafico[0]['respondidos'].toDouble(),
            label: '')
      ]);

      if (retornoApi.statusCode == 200) {
        return graficos;
      } else {
        return List<Grafico>.empty();
      }
    } catch (erro) {
      print('Erro getGraficosResposta $erro');
      return List<Grafico>.empty();
    }
  }

  Future<List<Medicamento>> getMedicamentosUsadosFiltro(String endpoint) async {
    Get.find<UsuarioProvider>().isSessionValid();
    try {
      var retornoApi = await get('remedios/usados$endpoint',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Medicamento.listFromJson(obj));

      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Medicamento>.empty();
      }
    } catch (erro) {
      print('Erro getMedicamentosUsadosFiltro $erro');
      return List<Medicamento>.empty();
    }
  }
}
