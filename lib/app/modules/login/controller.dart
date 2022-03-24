import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';

class LoginController extends GetxController {
  final UsuarioRepository repository;
  LoginController({required this.repository}) : assert(repository != null);
  @override
  void onInit() {
    //verificaSessao();
    super.onInit();
  }

  final _email = ''.obs;
  final _senha = ''.obs;
  final _loginErroMensagem = Rx<String?>(null);
  final _usuario = Rx<Usuario?>(null);
  final _token = ''.obs;
  final _isLoading = false.obs;

  get email => this._email.value;
  setEmail(value) => this._email.value = value;

  get senha => this._senha.value;
  setSenha(value) => this._senha.value = value;

  get loginErroMensagem => this._loginErroMensagem.value;
  set loginErroMensagem(value) => this._loginErroMensagem.value = value;

  get usuario => this._usuario.value;
  set usuario(value) => this._usuario.value = value;

  get token => this._token.value;
  set token(value) => this._token.value = value;

  get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  verificaLogin() {
    isLoading = true;
    EasyLoading.showInfo('Verificando...');
    repository.verificaLogin(email, senha).then((Response<dynamic> retorno) {
      EasyLoading.dismiss();
      isLoading = false;
      if (retorno is bool) {
        loginErroMensagem = 'Dados incorretos!';
      } else {
        loginErroMensagem = null;
        token = retorno.body['access_token'];
        //getUsuario();
        criaSessao(retorno.body['expires_in']);
        Get.offNamed('/');
      }
    });
  }

  criaSessao(int duracaoSessao) => repository.criaSessao(token, duracaoSessao);

  verificaSessao() => repository.verificaSessao();
//validar
  getUsuario() => repository
      .getUsuario()
      .then((Response<dynamic> retorno) => print(retorno));

  getSessaoToken() => token = repository.getSessaoToken();
}
