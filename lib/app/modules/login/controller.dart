import 'package:get/get.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';

class LoginController extends GetxController {
  final UsuarioRepository repository;
  LoginController({required this.repository}) : assert(repository != null);

  final _email = ''.obs;
  final _senha = ''.obs;
  final _isLogged = false.obs;
  final _loginErroMensagem = ''.obs;

  get email => this._email.value;
  set email(value) => this._email.value = value;

  get senha => this._senha.value;
  set senha(value) => this._senha.value = value;

  get isLogged => this._isLogged.value;
  set isLogged(value) => this._isLogged.value = value;

  get loginErroMensagem => this._loginErroMensagem.value;
  set loginErroMensagem(value) => this._loginErroMensagem.value = value;

  verificaLogin() =>
      repository.verificaLogin(email, senha).then<Usuario?>((Usuario? result) {
        print(result);
        if (result != null) {
          isLogged = true;
          loginErroMensagem = '';
          criaSessao(result.email);
          Get.toNamed('/');
        } else {
          isLogged = false;
          loginErroMensagem = 'Dados incorretos!';
        }
      });

  criaSessao(String token) => repository.criaSessao(token);

  verificaSessao(String token) => isLogged = repository.verificaSessao(token);
}
