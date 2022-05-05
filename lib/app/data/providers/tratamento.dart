import 'package:get/get.dart';
import 'package:healthbox/app/data/models/acompanhamento.dart';
import 'package:healthbox/app/data/models/like.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/app/data/models/questionario.dart';
import 'package:healthbox/app/data/models/tratamento.dart';
import 'package:healthbox/app/data/models/usuario.dart';
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
    httpClient.timeout = const Duration(seconds: 30);
    token = UsuarioProvider.token;

    super.onInit();
  }

  //=================================Acompanhamentos=====================================

  Future<List<Usuario>> getUsuariosAcompanhamentos<T>(String pesquisa) async {
    Get.find<UsuarioProvider>().isSessionValid();
    print('Bearer  $token');
    String filtro = pesquisa.trim().isEmpty ? 'nome' : 'nome=$pesquisa';
    try {
      var retornoApi = await get('acompanhamentos/vinculos/usuarios?$filtro',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => T == Paciente
              ? Paciente.listFromJson(obj)
              : Medico.listFromJson(obj));
      print(retornoApi.statusCode);
      print(retornoApi.body);
      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Usuario>.empty();
      }
    } catch (erro) {
      print('Erro getUsuariosAcompanhamentos $erro');
      return List<Usuario>.empty();
    }
  }

  Future<List<Acompanhamento>> getAcompanhamentos(int id) async {
    Get.find<UsuarioProvider>().isSessionValid();
    print('${httpClient.baseUrl}acompanhamentos?usuario_id=$id&ativo=1');

    try {
      var retornoApi = await get('acompanhamentos?usuario_id=$id&ativo=1',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Acompanhamento.listFromJson(obj));

      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Acompanhamento>.empty();
      }
    } catch (erro) {
      print('Erro getAcompanhamentos $erro');
      return List<Acompanhamento>.empty();
    }
  }

  salvarAcompanhamento(Acompanhamento acompanhamento) async {
    Get.find<UsuarioProvider>().isSessionValid();

    dynamic retornoApi;
    int id;
    if (acompanhamento.id == null) {
      retornoApi = await post(
        'acompanhamentos',
        acompanhamento.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
      id = retornoApi.body['acompanhamento']['id'];
    } else {
      retornoApi = await put(
        'acompanhamentos/${acompanhamento.id}',
        acompanhamento.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
      id = acompanhamento.id!;
    }
    print(retornoApi.statusCode);
    print(retornoApi.body);
    print('id acompanhamento =====  $id}');
    if (retornoApi.statusCode == 200) return id;
    return false;
  }

  salvarQuestionario(Questionario questionario) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;
    int id;

    if (questionario.id == null) {
      retornoApi = await post(
        'questionarios',
        questionario.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
      print(retornoApi.body);
      id = retornoApi.body['questionario']['id'];
    } else {
      retornoApi = await put(
        'questionarios/${questionario.id}',
        questionario.toJson(),
        headers: {'Authorization': 'Bearer  $token'},
      );
      id = questionario.id!;
    }
    print(retornoApi.statusCode);
    print(retornoApi.body);
    print('id questionario =====  $id}');
    if (retornoApi.statusCode == 200) return id;
    return false;
  }

  Future<bool> deletarAcompanhamento(int id) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;

    retornoApi = await delete(
      'acompanhamentos/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );
    print(retornoApi.statusCode);
    print(retornoApi.body);
    if (retornoApi.statusCode == 200) return true;
    return false;
    try {
      dynamic retornoApi;

      retornoApi = await delete(
        'acompanhamentos/$id',
        headers: {'Authorization': 'Bearer  $token'},
      );

      if (retornoApi.statusCode == 200) return true;
      return false;
    } catch (erro) {
      print('erro deletarAcompanhamento $erro');
      return false;
    }
  }

//=================================Questões=====================================
  salvarQuestao(Questao questao) async {
    Get.find<UsuarioProvider>().isSessionValid();
    try {
      dynamic retornoApi;
      if (questao.id == null) {
        retornoApi = await post(
          'questoes',
          questao.toJson(),
          headers: {'Authorization': 'Bearer  $token'},
        );
      } else {
        retornoApi = await put(
          'questoes/${questao.id}',
          questao.toJson(),
          headers: {'Authorization': 'Bearer  $token'},
        );
      }

      if (retornoApi.statusCode == 200)
        return retornoApi.body['questao']?['id'] ?? questao.id;
      return false;
    } catch (erro) {
      print('erro salvarQuestao $erro');
      return false;
    }
  }

  Future<bool> deletarQuestao(int id) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;
    retornoApi = await delete(
      'questoes/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> deletarOpcao(int id) async {
    Get.find<UsuarioProvider>().isSessionValid();
    dynamic retornoApi;
    retornoApi = await delete(
      'questoes/opcoes/$id',
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  salvarIntermediaria(Map<String, List<Map<String, dynamic>>> vinculos) async {
    Get.find<UsuarioProvider>().isSessionValid();
    print(vinculos);
    dynamic retornoApi;
    retornoApi = await post(
      'questoes/vinculos',
      vinculos,
      headers: {'Authorization': 'Bearer  $token'},
    );
    print(retornoApi.statusCode);
    print(retornoApi.body);
    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Questao>> getQuestoesPreCadastradas() async {
    Get.find<UsuarioProvider>().isSessionValid();

    try {
      var retornoApi = await get('questoes',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Questao.listFromJson(obj));

      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Questao>.empty();
      }
    } catch (erro) {
      print('Erro getQuestoesPreCadastradas $erro');
      return List<Questao>.empty();
    }
  }

//=================================Quesitonários=====================================
  salvarRespostas(Map<String, dynamic> respostas) async {
    Get.find<UsuarioProvider>().isSessionValid();

    dynamic retornoApi;
    retornoApi = await post(
      'questoes/respostas',
      respostas,
      headers: {'Authorization': 'Bearer  $token'},
    );
    print(retornoApi.statusCode);
    print(retornoApi.body);
    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<List<Questionario>> getQuestionarios({int? idAcompanhamento}) async {
    Get.find<UsuarioProvider>().isSessionValid();
    String filtro = '';
    if (idAcompanhamento != null) {
      filtro = '?acompanhamento_id=$idAcompanhamento';
    }

    try {
      var retornoApi = await get(
          'acompanhamentos/questionarios/responder$filtro',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Questionario.listFromJson(obj));
      print(retornoApi.statusCode);
      print(retornoApi.body);
      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Questionario>.empty();
      }
    } catch (erro) {
      print('Erro getQuestionarios $erro');
      return List<Questionario>.empty();
    }
  }

  getInfoAcompanhamento(int idAcompanhamento) async {
    Get.find<UsuarioProvider>().isSessionValid();

    try {
      var retornoApi = await get('acompanhamentos/$idAcompanhamento',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Acompanhamento.fromJson(obj));

      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return false;
      }
    } catch (erro) {
      print('Erro getInfoAcompanhamento $erro');
      return false;
    }
  }

//=================================Opiniões=====================================
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
    Get.find<UsuarioProvider>().isSessionValid();
    try {
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
      print('${httpClient.baseUrl}$endpoint');
      if (retornoApi.statusCode == 200) {
        return retornoApi.body!;
      } else {
        return List<Opiniao>.empty();
      }
    } catch (erro) {
      print('Erro getOpinioes $erro');
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
    try {
      var retornoApi = await get('remedios?nome=$filtro&page=1',
          headers: {'Authorization': 'Bearer  $token'},
          decoder: (obj) => Medicamento.listFromJson(obj));

      if (retornoApi.statusCode == 200 && retornoApi.body != null) {
        return retornoApi.body!;
      } else {
        return List<Medicamento>.empty();
      }
    } catch (erro) {
      print('Erro getMedicamentosFiltro $erro');
      return List<Medicamento>.empty();
    }
  }
}
