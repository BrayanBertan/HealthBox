import 'package:get/get.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
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
    Get.find<UsuarioProvider>().isSessionValid();
    var retornoApi = await delete(
      'usuarios/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> salvarCrm(Crm crm, int medicoId) async {
    Get.find<UsuarioProvider>().isSessionValid();
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

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> deletaCrm(int id) async {
    Get.find<UsuarioProvider>().isSessionValid();
    httpClient.baseUrl = baseUrl;
    var retornoApi = await delete(
      'crms/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Especializacao>?> getEspecializacoes(
      List<Especializacao> itens) async {
    try {
      var retornoApi = await get('especializacoes?page=1&nome',
          decoder: (obj) => Especializacao.listFromJson(obj));
      List<Especializacao> itensRetorno = retornoApi.body!;
      // itensRetorno
      //     .removeWhere((especializacao) => itens.contains(especializacao));
      itens.forEach((element1) => itensRetorno.removeWhere((element2) =>
          element1.especializacaoId == element2.especializacaoId));

      if (retornoApi.statusCode == 200) {
        return itensRetorno;
      } else {
        return List<Especializacao>.empty();
      }
    } catch (erro) {
      print('Erro getEspecializacoes $erro');
      return List<Especializacao>.empty();
    }
  }

  Future<bool> salvarEspecializacao(int medicoCrmId, especializacaoId) async {
    Get.find<UsuarioProvider>().isSessionValid();
    var dados = {
      "medico_crm_id": medicoCrmId,
      "especializacao_id": especializacaoId
    };

    dynamic retornoApi;
    retornoApi = await post(
      'especializacoes',
      dados,
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> deletaEspecializacao(int id) async {
    Get.find<UsuarioProvider>().isSessionValid();
    httpClient.baseUrl = baseUrl;

    var retornoApi = await delete(
      'especializacoes/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Vinculo>> getUsuariosDisponiveis(String nome) async {
    Get.find<UsuarioProvider>().isSessionValid();
    try {
      var retornoApi = await get(
          'solicitacoes-vinculos/usuarios-disponiveis?nome=$nome',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Vinculo.listFromJson(obj));

      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Vinculo>.empty();
      }
    } catch (erro) {
      print('Erro getUsuariosDisponiveis $erro');
      return List<Vinculo>.empty();
    }
  }

  Future<bool> salvarVinculo(int medicoId, pacienteId, {int? id}) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;
    if (id == null) {
      retornoApi = await post(
        'solicitacoes-vinculos?medico_id=$medicoId&paciente_id=$pacienteId',
        {},
        headers: {'Authorization': 'Bearer  $token'},
      );
    } else {
      retornoApi = await put(
        'solicitacoes-vinculos/$id',
        {'vinculado': 1},
        headers: {'Authorization': 'Bearer  $token'},
      );
    }
    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Vinculo>> getVinculos(int tipo) async {
    Get.find<UsuarioProvider>().isSessionValid();
    try {
      var retornoApi = await get('solicitacoes-vinculos?vinculado=$tipo',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Vinculo.listFromJson(obj));

      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Vinculo>.empty();
      }
    } catch (erro) {
      print('Erro getVinculos $erro');
      return List<Vinculo>.empty();
    }
  }

  Future<bool> deletaVinculo(int id) async {
    Get.find<UsuarioProvider>().isSessionValid();
    var retornoApi = await delete(
      'solicitacoes-vinculos/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }
}
