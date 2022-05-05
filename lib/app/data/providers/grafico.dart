import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
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
      print('${httpClient.baseUrl}graficos/$endpoint');
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

  Future<List<Medicamento>> getMedicamentosUsadosFiltro() async {
    Get.find<UsuarioProvider>().isSessionValid();
    try {
      var retornoApi = await get('remedios/usados',
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
