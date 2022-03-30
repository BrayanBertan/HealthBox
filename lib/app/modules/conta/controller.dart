import 'package:get/get.dart';
import 'package:healthbox/app/data/models/crm.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';

import '../../data/models/especializacao.dart';
import '../login/controller.dart';

class ContaController extends GetxController {
  final UsuarioRepository repository;
  final loginController = Get.find<LoginController>();
  dynamic usuario;

  ContaController({required this.repository}) : assert(repository != null) {
    usuario = loginController.getLogin();
    if (usuario is Medico) {
      crms.clear();
      crms.assignAll(usuario.crms);
    }
  }
  final especializacoes = <Especializacao>[].obs;

  final crms = <Crm>[].obs;

  final _buttonPressed = false.obs;
  final _loopActive = false.obs;
  final _carregandoDeleta = 0.obs;
  get buttonPressed => this._buttonPressed.value;
  set buttonPressed(value) => this._buttonPressed.value = value;

  get loopActive => this._loopActive.value;
  set loopActive(value) => this._loopActive.value = value;

  get carregandoDeleta => this._carregandoDeleta.value;
  set carregandoDeleta(value) => this._carregandoDeleta.value = value;

  confirmandoDeletarConta() async {
    if (loopActive) return;

    loopActive = true;

    while (buttonPressed) {
      if (carregandoDeleta < 100) carregandoDeleta = carregandoDeleta + 10;
      await Future.delayed(const Duration(milliseconds: 300));
      if (carregandoDeleta == 100) buttonPressed = false;
    }
    if (carregandoDeleta == 100) {
      repository.deletaUsuario(usuario.id).then((retorno) {
        if (retorno) {
          loginController.logout();
        }
      });
    }
    carregandoDeleta = 0;
    loopActive = false;
  }

  getEspecializacoes() {
    repository.getEspecializacoes().then((List<Especializacao>? retorno) {
      this.especializacoes.clear();
      this.especializacoes.assignAll(retorno!);
    });
  }
}
