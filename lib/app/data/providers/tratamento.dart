import 'package:get/get.dart';
import 'package:healthbox/app/data/models/like.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/models/tratamento.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/core/values/keys.dart';

import '../../modules/opinioes/widgets/sub_controllers/controller_filtro_opinoes.dart';
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

  salvarOpiniao(Opiniao opiniao) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;
    int id;
    if (opiniao.id == null) {
      retornoApi = await post(
        'opinioes',
        opiniao.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
      id = retornoApi.body['opiniao']['id'];
    } else {
      retornoApi = await put(
        'opinioes/${opiniao.id}',
        opiniao.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
      id = opiniao.id!;
    }

    if (retornoApi.statusCode == 200) return id;
    return false;
  }

  Future<bool> salvarTratamento(Tratamento tratamento) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;
    print(tratamento.toJson());
    if (tratamento.id == null) {
      retornoApi = await post(
        'tratamentos',
        tratamento.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
    } else {
      retornoApi = await put(
        'tratamentos/${tratamento.id}',
        tratamento.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
    }
    print(retornoApi.statusCode);
    print(retornoApi.body);
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

  Future<List<Opiniao>> getOpinioes(
      {int? pacienteId,
      int page = 1,
      required FiltroOpinioesController filtros,
      required String search}) async {
    print(filtros.medicamentosId);
    print('Bearer  $token');
    String filtrosParam = '';
    if (filtros.medicamentosSelecionados.first.id == 0) {
      filtrosParam = '${filtros.eficaz}${filtros.orderBy}$search';
    } else {
      filtrosParam =
          '${filtros.eficaz}${filtros.orderBy}${search}&remedios=${filtros.medicamentosId}';
    }

    String endpoint = 'opinioes?page=$page&ativo=1&paciente_id$filtrosParam';
    if (pacienteId != null)
      endpoint =
          'opinioes?page=$page&ativo=1&paciente_id=$pacienteId$filtrosParam';
    print('${httpClient.baseUrl}$endpoint');
    var retornoApi = await get(endpoint,
        headers: {'Authorization': 'Bearer  $token'},
        decoder: (obj) => Opiniao.listFromJson(obj));
    // print('${httpClient.baseUrl}$endpoint');
    if (retornoApi.statusCode == 200) {
      return retornoApi.body!;
    } else {
      return List<Opiniao>.empty();
    }
  }

  setLike(bool isLike, opiniaoId) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;

    retornoApi = await post(
      'likes',
      {'opiniao_id': opiniaoId, 'is_like': isLike ? 1 : 0},
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200)
      return Like.fromJson(retornoApi.body['like']);
    return false;
  }

  Future<bool> deleteLike(int likeId) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;

    retornoApi = await delete(
      'likes/$likeId',
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
