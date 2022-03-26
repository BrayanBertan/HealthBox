import 'dart:convert';

import 'package:get/get.dart';
import 'package:healthbox/app/data/services/storage.dart';
import 'package:healthbox/core/values/keys.dart';

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
    var retornoApi = await post(
      'auth/me',
      {},
      headers: {
        'Authorization': 'Bearer  $token'
      }, /*decoder: (obj) => Usuario.fromJson(obj)*/
    );
    if (retornoApi.statusCode == 200) return retornoApi;
    return false;
  }

  String getSessaoToken() {
    return _storage.read(keySessao)?['token'] ?? '';
  }

  salvarUsuario(Map<String, dynamic> usuario) async {
    return true;
    httpClient.baseUrl = 'http://10.0.2.2:3031/';
    var retornoApi = await post('usuarios', usuario);
    print(retornoApi.body);
    print(retornoApi.statusCode);
    httpClient.baseUrl = baseUrl;
    if (retornoApi.statusCode == 200) return retornoApi;
    return false;
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
