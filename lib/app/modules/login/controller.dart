import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/notificacao.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/routes/app_pages.dart';

import '../../data/providers/usuario.dart';

class LoginController extends GetxController {
  final UsuarioRepository repository;
  LoginController({required this.repository}) : assert(repository != null);
  @override
  void onInit() {
    super.onInit();
  }

  final _email = ''.obs;
  final _senha = ''.obs;
  final _loginErroMensagem = Rx<String?>(null);
  final _paciente = Rx<Paciente?>(null);
  final _medico = Rx<Medico?>(null);
  final _token = ''.obs;
  final _isLoading = false.obs;
  final notificacoes = <Notificacao>[].obs;
  final _redictToAcompanhamentos = false.obs;
  final _idRemetente = 0.obs;

  get email => this._email.value;
  setEmail(value) => this._email.value = value;

  get senha => this._senha.value;
  setSenha(value) {
    this._senha.value = value ?? '';
  }

  get loginErroMensagem => this._loginErroMensagem.value;
  set loginErroMensagem(value) => this._loginErroMensagem.value = value;

  get paciente => this._paciente.value;
  set paciente(value) => this._paciente.value = value;

  get medico => this._medico.value;
  set medico(value) => this._medico.value = value;

  get token => this._token.value;
  set token(value) => this._token.value = value;

  get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  get redictToAcompanhamentos => this._redictToAcompanhamentos.value;
  set redictToAcompanhamentos(value) =>
      this._redictToAcompanhamentos.value = value;

  get idRemetente => this._idRemetente.value;
  set idRemetente(value) => this._idRemetente.value = value;

  verificaLogin() {
    isLoading = true;
    EasyLoading.showInfo('Verificando...',
        duration: const Duration(seconds: 90));

    repository.verificaLogin(email.trim(), senha.trim()).then((retorno) {
      if (retorno is bool) {
        loginErroMensagem = 'Dados incorretos!';
        isLoading = false;
        EasyLoading.dismiss();
      } else {
        loginErroMensagem = null;
        token = retorno.body['access_token'];
        criaSessao(retorno.body['expires_in']);
        UsuarioProvider.token = token;
        getUsuario().then((val) {
          isLoading = false;
          EasyLoading.dismiss();
          Get.offNamed(Routes.INITIAL);
        });
        // Future.delayed(const Duration(seconds: 3)).then((value) {
        //
        // });
      }
    });
  }

  criaSessao(int duracaoSessao) => repository.criaSessao(token, duracaoSessao);

  verificaSessao() => repository.verificaSessao();

  salvarFcmToken(String token) {
    var usuario = getLogin();

    usuario.fcmToken = token;

    if (usuario.tipo == TipoUsuario.PACIENTE) {
      paciente.fcmToken = token;

      repository.salvarUsuario<Paciente>(paciente);
    } else {
      medico.fcmToken = token;
      repository.salvarUsuario<Medico>(medico);
    }
  }

  getUsuario() => repository.getUsuario().then((retorno) {
        if (retorno is bool) {
          logout();
        } else {
          if (retorno.tipo == TipoUsuario.PACIENTE) {
            paciente = retorno;
          } else {
            medico = retorno;
          }
          FirebaseMessaging.instance.getToken().then((token) {
            salvarFcmToken(token ?? '');
          });

          FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
            salvarFcmToken(token ?? '');
          }).onError((erro) {
            print('Erro FirebaseMessaging.instance.onTokenRefresh $erro');
          });
        }
      });

  getSessaoToken() => token = repository.getSessaoToken();

  logout() {
    paciente = null;
    medico = null;
    token = '';
    setEmail('');
    setSenha('');
    loginErroMensagem = null;
    repository.logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  dynamic getLogin() => paciente != null ? paciente : medico;

  enviarNotificacao(Notificacao notificacao) =>
      repository.enviarNotificacao(notificacao).then((retorno) {
        if (retorno) {
          print('sucesso ao enviar notificação controller');
        } else {
          print('erro ao enviar notificação controller');
        }
      });

  redirectNotificacao(Notificacao notificacao) async {
    switch (notificacao.tipo) {
      case 1:
        {
          if (Get.currentRoute != Routes.CONTA) {
            Get.toNamed(Routes.CONTA, arguments: true);
          } else {
            Get.back();
          }
        }

        break;
      case 2:
        {
          if (Get.currentRoute == Routes.ACOMPANHAMENTOS) {
            final controlerAcompanhamentos =
                Get.find<AcompanhamentosController>();
            int indexUsuario = controlerAcompanhamentos.usuariosAcompanhamentos
                .indexWhere((element) => element.id == 41);
            redictToAcompanhamentos = true;
            controlerAcompanhamentos.getAcompanhamentos(indexUsuario);
          } else if (Get.currentRoute != Routes.LISTAGEM_ACOMPANHAMENTOS) {
            redictToAcompanhamentos = true;
            idRemetente = notificacao.medico?.id ?? notificacao.paciente!.id;
            Get.toNamed(Routes.ACOMPANHAMENTOS);
          } else {
            Get.back();
          }
        }

        break;
      case 3:
        {}
        ;
        break;
    }
  }
}
