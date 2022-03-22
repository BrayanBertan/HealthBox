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

  Future<Response<dynamic>> verificaLogin(String email, String senha) async =>
      await post(
        'auth/login?password=$senha&email=$email',
        {},
      );

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

  Future<Response<dynamic>> getUsuario() async {
    return await post(
      'auth/me',
      {},
      headers: {
        'Authorization': 'Bearer  $token'
      }, /*decoder: (obj) => Usuario.fromJson(obj)*/
    );
  }

  String getSessaoToken() {
    return _storage.read(keySessao)?['token'] ?? '';
  }
}
