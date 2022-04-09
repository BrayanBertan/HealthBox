import 'package:get/get.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/core/values/keys.dart';

class TratamentoProvider extends GetConnect {
  static String token = '';
  @override
  void onInit() {
    //httpClient.defaultDecoder = Usuario.listFromJson;
    httpClient.baseUrl = baseUrl;
    token = UsuarioProvider.token;

    super.onInit();
  }

  Future<bool> salvarOpiniao(Opiniao opiniao) async {
    Get.find<UsuarioProvider>().isSessionValid();

    dynamic retornoApi;
    retornoApi = await post(
      'opinioes',
      opiniao.toJson(),
      headers: {'Authorization': 'Bearer  $token'},
    );
    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Opiniao>> getOpinioes({int? pacienteId, int page = 1}) async {
    print(page);
    var retornoApi = await get(
        'opinioes?page=$page&ativo=1&paciente_id&order_eficaz=asc&order_likes=asc',
        headers: {'Authorization': 'Bearer  $token'},
        decoder: (obj) => Opiniao.listFromJson(obj));

    if (retornoApi.statusCode == 200) {
      return retornoApi.body!;
    } else {
      return List<Opiniao>.empty();
    }
  }
}
