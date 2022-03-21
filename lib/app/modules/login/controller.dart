import 'package:get/get.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';

class LoginController extends GetxController {
  final UsuarioRepository repository;
  LoginController({required this.repository}) : assert(repository != null);
  @override
  void onInit() {
    verificaSessao();
    super.onInit();
  }

  final _email = ''.obs;
  final _senha = ''.obs;
  final _isLogged = false.obs;
  final _loginErroMensagem = Rx<String?>(null);
  final _usuario = Rx<Usuario?>(null);
  final _token = ''.obs;

  get email => this._email.value;
  set email(value) => this._email.value = value;
  emailFunction(String value) => email = value;

  get senha => this._senha.value;
  set senha(value) => this._senha.value = value;
  senhaFunction(String value) => senha = value;

  get isLogged => this._isLogged.value;
  set isLogged(value) => this._isLogged.value = value;

  get loginErroMensagem => this._loginErroMensagem.value;
  set loginErroMensagem(value) => this._loginErroMensagem.value = value;

  get usuario => this._usuario.value;
  set usuario(value) => this._usuario.value = value;

  get token => this._token.value;
  set token(value) => this._token.value = value;

  verificaLogin() => repository
          .verificaLogin('sarakemili@hotmail.com', '123456789')
          .then((Response<dynamic> retorno) {
        // print(retorno.body['access_token']);
        // print(retorno.body['expires_in']);
        if (retorno.statusCode == 200) {
          loginErroMensagem = null;
          token = retorno.body['access_token'];
          //getUsuario();
          criaSessao(retorno.body['expires_in']);
          Get.offNamed('/');
        } else {
          loginErroMensagem = 'Dados incorretos!';
        }
      });

  criaSessao(int duracaoSessao) => repository.criaSessao(token, duracaoSessao);

  verificaSessao() => repository.verificaSessao();

  getUsuario() => repository
      .getUsuario()
      .then((Response<dynamic> retorno) => print(retorno.body));

  getSessaoToken() => token = repository.getSessaoToken();
}
