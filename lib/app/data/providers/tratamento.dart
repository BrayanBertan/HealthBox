import 'package:get/get.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/core/values/keys.dart';

import '../models/medicamento.dart';

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
    print('Bearer $token');
    if (opiniao.id == null) {
      retornoApi = await post(
        'opinioes',
        opiniao.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
    } else {
      retornoApi = await put(
        'opinioes/${opiniao.id}',
        opiniao.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
    }

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> deletarOpiniao(int id) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;

    retornoApi = await delete(
      'opinioes/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Opiniao>> getOpinioes({int? pacienteId, int page = 1}) async {
    String endpoint =
        'opinioes?page=$page&ativo=1&paciente_id&order_eficaz=asc&order_likes=asc';
    if (pacienteId != null)
      endpoint =
          'opinioes?page=$page&ativo=1&paciente_id=$pacienteId&order_eficaz=asc&order_likes=asc';
    var retornoApi = await get(endpoint,
        headers: {'Authorization': 'Bearer  $token'},
        decoder: (obj) => Opiniao.listFromJson(obj));

    if (retornoApi.statusCode == 200) {
      return retornoApi.body!;
    } else {
      return List<Opiniao>.empty();
    }
  }

  Future<bool> setLike(bool isLike, opiniaoId) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;

    retornoApi = await post(
      'likes',
      {'opiniao_id': opiniaoId, 'is_like': isLike ? 1 : 0},
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> deleteLike(int opiniaoId) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;

    retornoApi = await delete(
      'likes/$opiniaoId',
      headers: {'Authorization': 'Bearer  $token'},
    );

    print(retornoApi.statusCode);
    print(retornoApi.body);
    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Medicamento>> getMedicamentosFiltro(String filtro) async {
    Get.find<UsuarioProvider>().isSessionValid();
    var retornoApi = await get('remedios?nome=$filtro&page=1',
        headers: {'Authorization': 'Bearer  $token'},
        decoder: (obj) => Medicamento.listFromJson(obj));

    if (retornoApi.statusCode == 200 && retornoApi.body != null) {
      return retornoApi.body!;
    } else {
      return List<Medicamento>.empty();
    }
  }
}
