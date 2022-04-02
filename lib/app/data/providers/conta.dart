import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/core/values/keys.dart';

import '../models/crm.dart';
import '../models/especializacao.dart';

class ContaProvider extends GetConnect {
  static String token = '';
  @override
  void onInit() {
    //httpClient.defaultDecoder = Usuario.listFromJson;
    httpClient.baseUrl = baseUrl;
    token = UsuarioProvider.token;
    super.onInit();
  }

  Future<bool> deletaUsuario(int id) async {
    var retornoApi = await delete(
      'usuarios/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );
    print(retornoApi.statusCode);
    print(retornoApi.body);
    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> salvarCrm(Crm crm, int medicoId) async {
    var dados = {
      ...crm.toJson(),
      ...{"medico_id": medicoId}
    };
    dados.remove('especializacoes');
    dynamic retornoApi;
    if (crm.id == null) {
      retornoApi = await post(
        'crms',
        dados,
        headers: {'Authorization': 'Bearer  $token'},
      );
    } else {
      retornoApi = await put(
        'crms/${crm.id}',
        dados,
        headers: {'Authorization': 'Bearer  $token'},
      );
    }
    print('aqui');
    print(retornoApi.statusCode);
    print(retornoApi.body);
    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> deletaCrm(int id) async {
    httpClient.baseUrl = baseUrl;
    var retornoApi = await delete(
      'crms/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Especializacao>?> getEspecializacoes() async {
    var retornoApi = await get('especializacoes?page=1&nome',
        decoder: (obj) => Especializacao.listFromJson(obj));
    if (retornoApi.statusCode == 200) {
      return retornoApi.body;
    } else {
      return List<Especializacao>.empty();
    }
  }
}
