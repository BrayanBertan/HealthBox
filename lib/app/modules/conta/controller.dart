import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/crm.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';

import '../../data/models/especializacao.dart';
import '../login/controller.dart';

class ContaController extends GetxController {
  final UsuarioRepository repository;
  final loginController = Get.find<LoginController>();
  final dadosController = Get.find<DadosUsuarioController>();
  dynamic usuario;

  ContaController({required this.repository}) : assert(repository != null) {
    usuario = loginController.getLogin();
    if (usuario is Medico) {
      crms.clear();
      crms.assignAll(usuario.crms);
      crmController.clear();
    }
  }
  final especializacoes = <Especializacao>[].obs;

  final crms = <Crm>[].obs;
  final _buttonPressed = false.obs;
  final _loopActive = false.obs;
  final _carregandoDeleta = 0.obs;
  final _crm = Rx<String?>(null);
  final _crmuf = 'SC'.obs;
  final _crmErroMensagem = Rx<String?>(null);
  final _isLoading = false.obs;
  final crmController = TextEditingController();

  get buttonPressed => this._buttonPressed.value;
  set buttonPressed(value) => this._buttonPressed.value = value;

  get isLoading => this._isLoading.value;
  set isLoading(value) => this._isLoading.value = value;

  get crmErroMensagem => this._crmErroMensagem.value;
  set crmErroMensagem(value) => this._crmErroMensagem.value = value;

  get crm => this._crm.value;
  set crm(value) => this._crm.value = value;

  get crmuf => this._crmuf.value;
  set crmuf(value) => this._crmuf.value = value;

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

  salvarCrm() async {
    isLoading = true;
    dadosController.setCrm(crm);
    dadosController.setCrmUf(crmuf);

    if (crm == null || crm!.trim().isEmpty || crm!.trim().length < 4) {
      crmErroMensagem = 'Campo obrigatório';
      isLoading = false;
      return;
    }

    await validaCrm();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!dadosController.isCrmValid) {
      crmErroMensagem = 'Crm inválido';
      isLoading = false;
      return;
    }
    await verificaCrm();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!dadosController.crmVerifica) {
      crmErroMensagem = 'Crm em uso';
      isLoading = false;
      return;
    }
    repository.salvarCrm(usuario.id, crm, crmuf).then((retorno) {
      if (retorno) {
        EasyLoading.showToast('Crm $crm  $crmuf adicionado com sucesso',
            toastPosition: EasyLoadingToastPosition.bottom);
        crmController.clear();
        crmuf = 'SC';
        crmErroMensagem = null;
        atualizaUsuarioCrms();
      } else {
        crmErroMensagem = 'Erro ao salvar crm';
      }

      isLoading = false;
    });
  }

  verificaCrm() async {
    await dadosController.verificaCrm();
  }

  validaCrm() async {
    await dadosController.validaCRM();
  }

  deletarCrm(int crmId, String crm) {
    repository.deletaCrm(crmId).then((retorno) {
      if (retorno) {
        EasyLoading.showToast('Crm $crm deletado com sucesso',
            toastPosition: EasyLoadingToastPosition.bottom);
        getEspecializacoes();
      } else {
        EasyLoading.showToast('Erro ao deletar Crm $crm',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }

  atualizaUsuarioCrms() async {
    await loginController.getUsuario();
    usuario = loginController.getLogin();
    crms.clear();
    crms.assignAll(usuario.crms);
  }

  getEspecializacoes() {
    repository.getEspecializacoes().then((List<Especializacao>? retorno) {
      this.especializacoes.clear();
      this.especializacoes.assignAll(retorno!);
    });
  }
}
