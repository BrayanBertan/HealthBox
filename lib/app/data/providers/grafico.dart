import 'package:get/get.dart';
import 'package:healthbox/app/data/models/grafico.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/core/values/keys.dart';

class GraficoProvider extends GetConnect {
  static String token = '';
  @override
  void onInit() {
    //httpClient.defaultDecoder = Usuario.listFromJson;
    httpClient.baseUrl = baseUrl;
    token = UsuarioProvider.token;

    super.onInit();
  }

  Future<List<Grafico>> getGraficos({required String medicamentos}) async {
    var retornoApi = await get('graficos/paciente-remedio',
        headers: {'Authorization': 'Bearer  $token'},
        decoder: (obj) => Grafico.listFromJson(obj));

    if (retornoApi.statusCode == 200) {
      return retornoApi.body!;
    } else {
      return List<Grafico>.empty();
    }
  }
}
