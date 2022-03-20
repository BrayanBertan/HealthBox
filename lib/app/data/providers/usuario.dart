import 'package:get/get.dart';
import 'package:healthbox/app/data/models/usuario.dart';

class UsuarioProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = Usuario.listFromJson;
    httpClient.baseUrl = baseUrl;
    super.onInit();
  }

  Future<bool> verificaLogin(String email, String senha) async {
    return true;
  }
}
