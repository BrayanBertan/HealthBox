import 'package:get/get.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/app/data/services/storage.dart';
import 'package:healthbox/core/values/keys.dart';

class UsuarioProvider extends GetConnect {
  final _storage = Get.find<StorageService>();
  @override
  void onInit() {
    httpClient.defaultDecoder = Usuario.listFromJson;
    httpClient.baseUrl = baseUrl;
    super.onInit();
  }

  Future<Usuario?> verificaLogin(String email, String senha) async {
    return Usuario.fromJson({
      'cpf': '9999999',
      'altura': 1.67,
      'peso': 67.0,
      'id': 1,
      'tipo': 'PACIENTE',
      'nome': 'Brayan Bertan',
      'email': 'brayanbertan@gmail.com',
      'senha': '123456',
      'data_nascimento': DateTime.parse('1998-06-23'),
      'telefone': '99999999',
      'fotoPath': 'aaaaa',
      'genero': 'MASCULINO',
      'ativo': 1
    });
  }

  criaSessao(String token) => _storage.write(token,
      '${DateTime.now().toUtc().add(const Duration(hours: tempoSessao))}');

  bool verificaSessao(String token) {
    var retorno = _storage.read(token);
    if (retorno == null) {
      return false;
    }
    return DateTime.parse(retorno)
            .difference(DateTime.now().toUtc())
            .inMinutes >
        0;
  }
}
