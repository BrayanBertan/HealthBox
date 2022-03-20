import 'package:get/get.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/app/data/services/storage.dart';

class UsuarioProvider extends GetConnect {
  final _storage = Get.find<StorageService>();
  @override
  void onInit() {
    httpClient.defaultDecoder = Usuario.listFromJson;
    httpClient.baseUrl = baseUrl;
    super.onInit();
  }

  Future<bool> verificaLogin(String email, String senha) async {
    return true;
  }

  criaSessao(String token) => _storage.write(token, DateTime.now().toUtc());

  bool verificaSessao(String token) =>
      DateTime.now().toUtc().difference(_storage.read(token)).inMinutes > 0;
}
