import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/core/extensions/validacoes.dart';
import 'package:intl/intl.dart';

class DadosUsuarioController extends GetxController {
  DadosUsuarioController();
//===============Todos===================
  //=====Variaveis=====
  final _activeStepIndex = 0.obs;
  final _validStep = false.obs;
  //=====Getters e Setters=====
  get activeStepIndex => this._activeStepIndex.value;
  set activeStepIndex(value) => this._activeStepIndex.value = value;
  activeStepIndexFunction(int value) =>
      activeStepIndex = isValidStep(activeStepIndex) ? value : activeStepIndex;
  activeStepIndexIncrease() => activeStepIndex++;
  activeStepIndexDecrease() => activeStepIndex--;
  get validStep => this._validStep.value;
  set validStep(value) => this._validStep.value = value;
  //=====Validações=====
  bool step1Valido() =>
      nomeValido() &&
      telefoneValido() &&
      dataNascimentoValida() &&
      fotoValida();
  bool step2Valido() =>
      emailValido() && senhaValida() && tipoValido() && generoValido();
  bool step3PacienteValido() => cpfValido() && alturaValida() && pesoValido();
  bool step3MedicoValido() =>
      crmValido() && descricaoValido() && especializacaoValida();
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
    print('$step $activeStepIndex ${isValidStep(step)}');
    if (step == activeStepIndex) return StepState.editing;
    if (step != activeStepIndex && isValidStep(step)) return StepState.complete;
    if (step != activeStepIndex && !isValidStep(step))
      return StepState.disabled;
    return StepState.disabled;
  }

//==========STEP 1=======================
  //=====Variaveis=====
  final _foto = Rx<String?>(null);
  final _dataNascimento = Rx<DateTime?>(null);
  final _nome = TextEditingController();
  final _telefone = TextEditingController();
  //=====Getters e Setters=====
  get foto => this._foto.value;
  set foto(value) => this._foto.value = value;
  get dataNascimento => this._dataNascimento.value;
  set dataNascimento(value) => this._dataNascimento.value = value;
  String formataDataNascimento() => dataNascimento == null
      ? ''
      : DateFormat('dd/MM/yyyy').format(dataNascimento);
  get nome => this._nome.text;
  set nome(value) => this._nome.text = value;
  get telefone => this._telefone.text;
  set telefone(value) => this._telefone.text = value;
  //=====Validações=====
  bool nomeValido() => nome != null && nome.trim().isNotEmpty;
  String? nomeErroMensagem() {
    if (nome.value == null || nomeValido()) return null;
    return 'Campo obrigatorio';
  }

  bool telefoneValido() => telefone != null && telefone.trim().isNotEmpty;
  String? telefoneErroMensagem() {
    if (telefone.value == null || telefoneValido()) return null;
    return 'Campo obrigatorio';
  }

  bool fotoValida() => foto != null;
  String? fotoErroMensagem() {
    if (fotoValida()) return null;
    return 'Campo obrigatorio';
  }

  bool dataNascimentoValida() => dataNascimento != null;
  String? dataNascimentoErroMensagem() {
    if (fotoValida()) return null;
    return 'Campo obrigatorio';
  }

//==========STEP 2=======================
  //=====Variaveis=====
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _tipo = TipoUsuario.PACIENTE.obs;
  final _genero = Genero.MASCULINO.obs;
  //=====Getters e Setters=====
  get email => this._email.text;
  set email(value) => this._email.text = value;
  get senha => this._senha.text;
  set senha(value) => this._senha.text = value;
  get tipo => this._tipo.value;
  set tipo(value) => this._tipo.value = value;
  tipoFunction(TipoUsuario value) => tipo = value;
  get genero => this._genero.value;
  set genero(value) => this._genero.value = value;

  //=====Validações=====
  bool emailValido() =>
      email != null &&
      email.trim().isNotEmpty &&
      email.toString().isEmailValid();

  String? emailErroMensagem() {
    if (email.value == null || emailValido()) return null;
    return 'Campo obrigatorio';
  }

  bool senhaValida() => senha != null && senha.trim().isNotEmpty;

  String? senhaErroMensagem() {
    if (senha.value == null || senhaValida()) return null;
    return 'Campo obrigatorio';
  }

  bool generoValido() => genero != null && genero.trim().isNotEmpty;

  String? generoErroMensagem() {
    if (genero.value == null || generoValido()) return null;
    return 'Campo obrigatorio';
  }

  bool tipoValido() => tipo != null && tipo.trim().isNotEmpty;

  String? tipoErroMensagem() {
    if (tipo.value == null || tipoValido()) return null;
    return 'Campo obrigatorio';
  }

//==========STEP 3 Paciente=======================
//=====Variaveis=====
  final _cpf = ''.obs;
  final _altura = 0.0.obs;
  final _peso = 0.0.obs;
  //=====Getters e Setters=====
  get cpf => this._cpf.value;
  set cpf(value) => this._cpf.value = value;
  get altura => this._altura.value;
  set altura(value) => this._altura.value = value;
  get peso => this._peso.value;
  set peso(value) => this._peso.value = value;
  //=====Validações=====
  bool cpfValido() => cpf != null && cpf.trim().isNotEmpty;

  String? cpfErroMensagem() {
    if (cpf.value == null || cpfValido()) return null;
    return 'Campo obrigatorio';
  }

  bool alturaValida() => altura != null && altura.trim().isNotEmpty;

  String? alturaErroMensagem() {
    if (altura.value == null || alturaValida()) return null;
    return 'Campo obrigatorio';
  }

  bool pesoValido() => peso != null && peso.trim().isNotEmpty;

  String? pesoErroMensagem() {
    if (peso.value == null || pesoValido()) return null;
    return 'Campo obrigatorio';
  }

//==========STEP 3 Médico=======================
//=====Variaveis=====
  final _crm = ''.obs;
  final _descricao = 0.0.obs;
  final _especializacao = 0.0.obs;
  //=====Getters e Setters=====
  get crm => this._crm.value;
  set crm(value) => this._crm.value = value;
  get descricao => this._descricao.value;
  set descricao(value) => this._descricao.value = value;
  get especializacao => this._especializacao.value;
  set especializacao(value) => this._especializacao.value = value;
  //=====Validações=====
  bool crmValido() => crm != null && crm.trim().isNotEmpty;

  String? crmErroMensagem() {
    if (crm.value == null || crmValido()) return null;
    return 'Campo obrigatorio';
  }

  bool descricaoValido() => descricao != null && descricao.trim().isNotEmpty;

  String? descricaoErroMensagem() {
    if (descricao.value == null || descricaoValido()) return null;
    return 'Campo obrigatorio';
  }

  bool especializacaoValida() =>
      especializacao != null && especializacao.trim().isNotEmpty;

  String? especializacaoErroMensagem() {
    if (especializacao.value == null || especializacaoValida()) return null;
    return 'Campo obrigatorio';
  }
//==========STEP 4=======================

}
