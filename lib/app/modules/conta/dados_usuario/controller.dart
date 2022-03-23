import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/core/extensions/validacoes.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:intl/intl.dart';

import '../../../data/models/usuario.dart';

class DadosUsuarioController extends GetxController {
  DadosUsuarioController() {}
//===============Todos===================
  //=====Variaveis=====
  final usuario = Rx<Usuario?>(null);
  final _activeStepIndex = 0.obs;
  final _validStep = false.obs;
  //=====Getters e Setters=====
  get activeStepIndex => this._activeStepIndex.value;
  setActiveStepIndex(value) => this._activeStepIndex.value =
      !isValidStep(activeStepIndex) ? value : activeStepIndex;
  activeStepIndexIncrease() => this._activeStepIndex.value++;
  activeStepIndexDecrease() => this._activeStepIndex.value--;
  get validStep => this._validStep.value;
  set validStep(value) => this._validStep.value = value;
  //=====Validações=====
  bool step1Valido() =>
      nomeValido() &&
      telefoneValido() &&
      dataNascimentoValida() &&
      fotoValida();
  bool step2Valido() => emailValido() && senhaValida();
  bool step3PacienteValido() => cpfValido() && alturaValida() && pesoValido();
  bool step3MedicoValido() => crmValido() && descricaoValido();
  bool isValidStep(int step) {
    bool retorno = false;
    int index = (step == 2 && tipo == TipoUsuario.MEDICO) ? 4 : step;
    switch (index) {
      case 0:
        retorno = step1Valido();
        break;
      case 1:
        retorno = step2Valido();
        break;
      case 2:
        retorno = step3PacienteValido();
        break;
      case 3:
        retorno = false;
        break;
      default:
        retorno = step3MedicoValido();
    }
    return retorno;
  }

  StepState getStepState(int step) {
    //return StepState.indexed;
    if (step == activeStepIndex) return StepState.editing;
    if (step != activeStepIndex && isValidStep(step)) return StepState.complete;
    if (step != activeStepIndex && !isValidStep(step)) return StepState.indexed;
    return StepState.indexed;
  }

//==========STEP 1=======================
  //=====Variaveis=====
  final _foto = Rx<dynamic?>(null);
  final _dataNascimento = Rx<DateTime?>(null);
  final _nome = Rx<String?>(null);
  final _telefone = Rx<String?>(null);
  //=====Getters e Setters=====
  get foto => this._foto.value;
  set foto(value) => this._foto.value = value;
  get dataNascimento => this._dataNascimento.value;
  set dataNascimento(value) => this._dataNascimento.value = value;
  String formataDataNascimento() => dataNascimento == null
      ? ''
      : DateFormat('dd/MM/yyyy').format(dataNascimento);
  get nome => this._nome.value;
  setNome(value) => this._nome.value = value;
  get telefone => this._telefone.value;
  setTelefone(value) => this._telefone.value = value;
  //=====Validações=====
  bool nomeValido() => nome != null && nome.trim().isNotEmpty;
  String? get nomeErroMensagem {
    if (nome == null || nomeValido()) return null;
    return 'Campo obrigatorio';
  }

  bool telefoneValido() => telefone != null && telefone.trim().isNotEmpty;
  String? get telefoneErroMensagem {
    if (telefone == null || telefoneValido()) return null;
    return 'Campo obrigatorio';
  }

  bool fotoValida() => foto != null;

  bool dataNascimentoValida() => dataNascimento != null;

  void onImageSelected(File image) async {
    Get.back();
    File tmpFile = File(image.path);
    foto = tmpFile.path;
  }

//==========STEP 2=======================
  //=====Variaveis=====
  final _email = Rx<String?>(null);
  final _senha = Rx<String?>(null);
  final _tipo = TipoUsuario.PACIENTE.obs;
  final _genero = Genero.MASCULINO.obs;
  //=====Getters e Setters=====
  get email => this._email.value;
  setEmail(value) => this._email.value = value;
  get senha => this._senha.value;
  setSenha(value) => this._senha.value = value;
  get tipo => this._tipo.value;
  setTipo(value) => this._tipo.value = value;
  get tipoName => _tipo.value.name;
  get genero => this._genero.value;
  setGenero(value) => this._genero.value = value;
  get generoName => _genero.value.name;

  //=====Validações=====
  bool emailValido() =>
      email != null &&
      email.trim().isNotEmpty &&
      email.toString().isEmailValid();

  String? get emailErroMensagem {
    if (email == null || emailValido()) return null;
    return 'Campo obrigatorio';
  }

  bool senhaValida() => senha != null && senha.trim().isNotEmpty;

  String? get senhaErroMensagem {
    if (senha == null || senhaValida()) return null;
    return 'Campo obrigatorio';
  }

//==========STEP 3 Paciente=======================
//=====Variaveis=====
  final _cpf = Rx<String?>(null);
  final _altura = Rx<String?>(null);
  final _peso = Rx<String?>(null);
  //=====Getters e Setters=====
  get cpf => this._cpf.value;
  setCpf(value) => this._cpf.value = value;
  get altura => this._altura.value;
  setAltura(value) => this._altura.value = value.replaceAll(',', '.');
  get peso => this._peso.value;
  setPeso(value) => this._peso.value = value.replaceAll(',', '.');
  //=====Validações=====
  bool cpfValido() => cpf != null && cpf.trim().isNotEmpty;

  String? get cpfErroMensagem {
    if (cpf == null || cpfValido()) return null;
    return 'Campo obrigatorio';
  }

  bool alturaValida() => altura != null && altura.trim().isNotEmpty;

  String? get alturaErroMensagem {
    if (altura == null || alturaValida()) return null;
    return 'Campo obrigatorio';
  }

  bool pesoValido() => peso != null && peso.trim().isNotEmpty;

  String? get pesoErroMensagem {
    if (peso == null || pesoValido()) return null;
    return 'Campo obrigatorio';
  }

//==========STEP 3 Médico=======================
//=====Variaveis=====
  final _crm = Rx<String?>(null);
  final _descricao = Rx<String?>(null);
  final _especializacao = especializacoes[0].obs;
  //=====Getters e Setters=====
  get crm => this._crm.value;
  setCrm(value) => this._crm.value = value;
  get descricao => this._descricao.value;
  setDescricao(value) => this._descricao.value = value;
  get especializacao => this._especializacao.value;
  setEspecializacao(value) => this._especializacao.value = value;
  //=====Validações=====
  bool crmValido() => crm != null && crm.trim().isNotEmpty;

  String? get crmErroMensagem {
    if (crm == null || crmValido()) return null;
    return 'Campo obrigatorio';
  }

  bool descricaoValido() => descricao != null && descricao.trim().isNotEmpty;

  String? get descricaoErroMensagem {
    if (descricao == null || descricaoValido()) return null;
    return 'Campo obrigatorio';
  }
//==========STEP 4=======================

}
