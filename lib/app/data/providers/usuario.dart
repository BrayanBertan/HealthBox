import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/services/storage.dart';
import 'package:healthbox/core/values/keys.dart';

import '../../modules/login/controller.dart';
import '../models/especializacao.dart';
import '../models/medico.dart';
import '../models/paciente.dart';

class UsuarioProvider extends GetConnect {
  final _storage = Get.find<StorageService>();
  static String token = '';
  @override
  void onInit() {
    //httpClient.defaultDecoder = Usuario.listFromJson;
    httpClient.baseUrl = baseUrl;
    super.onInit();
  }

  verificaLogin(String email, String senha) async {
    httpClient.baseUrl = baseUrl;

    var retornoApi = await post(
      'auth/login?password=$senha&email=$email',
      {},
    );

    if (retornoApi.statusCode == 200) return retornoApi;
    return false;
  }

  criaSessao(String token, int duracaoSessao) {
    var data = {
      'token': token,
      'data_expiracao':
          '${DateTime.now().toUtc().add(Duration(seconds: duracaoSessao))}'
    };
    _storage.write(keySessao, data);
  }

  bool verificaSessao() {
    var retorno = _storage.read(keySessao);
    if (retorno == null) {
      return false;
    }

    bool isNotExpired = DateTime.parse(retorno['data_expiracao'])
            .difference(DateTime.now().toUtc())
            .inMinutes >
        0;
    if (!isNotExpired) _storage.remove(keySessao);
    return isNotExpired;
  }

  getUsuario() async {
    isSessionValid();
    var retornoApi = await post('auth/me', {},
        headers: {'Authorization': 'Bearer  $token'},
        decoder: (obj) =>
            obj['tipo'] == 'P' ? Paciente.fromJson(obj) : Medico.fromJson(obj));

    if (retornoApi.statusCode == 200) return retornoApi.body;
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

  String getSessaoToken() {
    return _storage.read(keySessao)?['token'] ?? '';
  }

  logout() {
    _storage.remove(keySessao);
    token = '';
  }

  isSessionValid() async {
    if (!verificaSessao()) {
      EasyLoading.showInfo('Sessão expirada!');
      await Future.delayed(const Duration(milliseconds: 500));
      Get.find<LoginController>().logout();
    }
  }

  salvarUsuario(Map<String, dynamic> usuario) async {
    dynamic retornoApi;
    if (usuario.containsKey('id')) {
      isSessionValid();
      retornoApi = await put(
        'usuarios/${usuario['id']}',
        usuario,
        headers: {'Authorization': 'Bearer  $token'},
      );
    } else {
      retornoApi = await post(
        'auth/register',
        usuario,
      );
    }

    if (retornoApi.statusCode == 200) return true;
    return false;
  }

  Future<bool> verificaDadosRepetidos(
      {String email = '',
      crm = '',
      cpf = '',
      uf = '',
      tipoPesquisa = ''}) async {
    httpClient.baseUrl = baseUrl;

    var retornoApi = await get(
      'usuarios/validate?crm=$crm&email=$email&cpf=$cpf&estado_sigla=$uf',
    );

    return retornoApi.body[tipoPesquisa]['validate'];
  }

  validaCRM(String crm, String uf) async {
    httpClient.baseUrl = '';
    var retornoApi = await get(
        'https://portal.cfm.org.br/api_rest_php/api/v1/medicos/buscar_foto/$crm/$uf');

    httpClient.baseUrl = baseUrl;
    var retorno = jsonDecode(retornoApi.body)['dados']?[0];
    if (retorno != null && retornoApi.statusCode == 200) {
      retorno['TELEFONE'] = retorno['TELEFONE']?.split(',')?[0] ?? '';
      return retorno;
    } else {
      return false;
    }

    // var dados = jsonDecode(retornoApi.body)['dados'][0];
    // var retorno = {
    //   'nome': dados['NOME'],
    //   'situacao': dados['SITUACAO'],
    //   'endereco': dados['ENDERECO'],
    //   'telefone': dados['TELEFONE'],
    // };
    // retornoApi = await get(
    //     'https://portal.cfm.org.br/wp-content/themes/portalcfm/assets/php/foto_medico.php?crm=$crm&uf=$uf&hash=${dados['HASH']}');
  }
}
// Future<Response>
