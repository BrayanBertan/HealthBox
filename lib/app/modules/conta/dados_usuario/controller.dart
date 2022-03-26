import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';
import 'package:healthbox/core/extensions/validacoes.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/easy_loading_config.dart';

class DadosUsuarioController extends GetxController {
  final UsuarioRepository repository;
  DadosUsuarioController({required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    interval(_crm, (val) => validaCRM(),
        time: const Duration(milliseconds: 1000));
    interval(_crmUf, (val) => validaCRM(),
        time: const Duration(milliseconds: 500));
  }

//===============Todos===================
  //=====Variaveis=====
  final _id = Rx<int?>(null);
  final _activeStepIndex = 0.obs;
  final _validStep = false.obs;
  //=====Getters e Setters=====
  get activeStepIndex => this._activeStepIndex.value;
  setActiveStepIndex(value) => this._activeStepIndex.value =
      isValidStep(activeStepIndex) || value < activeStepIndex
          ? value
          : activeStepIndex;
  activeStepIndexIncrease() => this._activeStepIndex.value++;
  activeStepIndexDecrease() => this._activeStepIndex.value--;
  get validStep => this._validStep.value;
  set validStep(value) => this._validStep.value = value;
  //=====Validações=====
  bool step0Valido() {
    if (tipo == TipoUsuario.PACIENTE && cpfValido()) return true;
    if (tipo == TipoUsuario.MEDICO && crmValido()) return true;
    return false;
  }

  bool step1Valido() =>
      nomeValido() &&
      telefoneValido() &&
      dataNascimentoValida() &&
      fotoValida();
  bool step2Valido() => emailValido() && senhaValida();
  bool step3PacienteValido() => alturaValida() && pesoValido();
  bool step3MedicoValido() => descricaoValido();
  bool step4Valido() {
    if (!step1Valido() || !step2Valido()) return false;
    if (tipo == TipoUsuario.PACIENTE && !step3PacienteValido()) return false;
    if (tipo == TipoUsuario.MEDICO && !step3MedicoValido()) return false;
    return true;
  }

  bool isValidStep(int step) {
    bool retorno = false;
    int index = (step == 3 && tipo == TipoUsuario.MEDICO) ? 5 : step;
    switch (index) {
      case 0:
        retorno = step0Valido();
        break;
      case 1:
        retorno = step1Valido();
        break;
      case 2:
        retorno = step2Valido();
        break;
      case 3:
        retorno = step3PacienteValido();
        break;
      case 4:
        retorno = step4Valido();
        break;
      default:
        retorno = step3MedicoValido();
    }
    return retorno;
  }

  StepState getStepState(int step) {
    if (step == activeStepIndex) return StepState.editing;
    if (step != activeStepIndex && isValidStep(step)) return StepState.complete;
    if (step != activeStepIndex && !isValidStep(step)) return StepState.indexed;
    return StepState.indexed;
  }

  //==========STEP 0=======================
  //=====Variaveis=====
  final _tipo = TipoUsuario.PACIENTE.obs;
  final _cpf = Rx<String?>(null);
  final _crm = Rx<String?>(null);
  final _isCrmValid = false.obs;
  final _crmUf = 'SC'.obs;
  //=====Getters e Setters=====
  get tipo => this._tipo.value;
  setTipo(value) {
    if (value == TipoUsuario.PACIENTE) {
      clearTextControllers();
    }
    this._tipo.value = value;
  }

  get tipoName => _tipo.value.name;

  get cpf => this._cpf.value;
  setCpf(value) => this._cpf.value = value;
  get crmUf => this._crmUf.value;
  setCrmUf(value) => this._crmUf.value = value;
  get isCrmValid => this._isCrmValid.value;
  set isCrmValid(value) => this._isCrmValid.value = value;

  get crm => this._crm.value;
  setCrm(value) => this._crm.value = value;
  //=====Validações=====

  bool crmValido() => crm != null && crm.trim().isNotEmpty && isCrmValid;

  String? get crmErroMensagem {
    if (crm == null || crmValido()) return null;
    if (!isCrmValid) return 'CRM invalido ou inativo';
    return 'Campo obrigatorio';
  }

  bool cpfValido() =>
      cpf != null && cpf.trim().isNotEmpty && cpf.trim().length == 14;

  String? get cpfErroMensagem {
    if (cpf == null || cpfValido()) return null;
    return 'Campo obrigatorio';
  }

//==========STEP 1=======================
  //=====Variaveis=====
  final _foto = Rx<dynamic?>(null);
  final _dataNascimento = Rx<DateTime?>(null);
  final _nome = Rx<String?>(null);
  final nomeController = TextEditingController();
  final _telefone = Rx<String?>(null);
  final telefoneController = TextEditingController();

  //=====Getters e Setters=====

  get foto => this._foto.value;
  set foto(value) => this._foto.value = value;
  get dataNascimento => this._dataNascimento.value;
  set dataNascimento(value) => this._dataNascimento.value = value;
  String get formataDataNascimento => dataNascimento == null
      ? ''
      : DateFormat('dd/MM/yyyy').format(dataNascimento);
  get nome => this._nome.value;
  setNome(value) => this._nome.value = value;
  get telefone => this._telefone.value;
  setTelefone(value) => this._telefone.value = value;

  //=====Validações=====
  bool nomeValido() =>
      nome != null &&
      nome.trim().isNotEmpty &&
      nome.trim().length >= 3 &&
      nome.trim().length <= 100;
  String? get nomeErroMensagem {
    if (nome == null || nomeValido()) return null;
    if (nome.trim().length < 3) return 'Minimo de 3 caracteres';
    return 'Campo obrigatorio';
  }

  bool telefoneValido() =>
      telefone != null &&
      telefone.trim().isNotEmpty &&
      telefone.trim().length <= 50;
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
  final _senhaRepeticao = Rx<String?>(null);

  final _genero = Genero.MASCULINO.obs;
  //=====Getters e Setters=====
  get email => this._email.value;
  setEmail(value) => this._email.value = value;
  get senha => this._senha.value;
  setSenha(value) => this._senha.value = value;
  get senhaRepeticao => this._senhaRepeticao.value;
  setSenhaRepeticao(value) => this._senhaRepeticao.value = value;

  get genero => this._genero.value;
  setGenero(value) => this._genero.value = value;
  get generoName => _genero.value.name;

  //=====Validações=====
  bool emailValido() =>
      email != null &&
      email.trim().isNotEmpty &&
      email.toString().isEmailValid() &&
      email.trim().length <= 50;

  String? get emailErroMensagem {
    if (email == null || emailValido()) return null;
    if (email != null && !email.toString().isEmailValid())
      return 'Email invalido';
    return 'Campo obrigatorio';
  }

  bool senhaValida() =>
      senha != null &&
      senha.trim().isNotEmpty &&
      senha.trim().length >= 8 &&
      //senha.trim() == senhaRepeticao?.trim() &&
      senha.trim().length <= 50;

  String? get senhaErroMensagem {
    if (senha == null || senhaValida()) return null;
    if (senha.trim().length < 8) return 'Minimo de 8 caracteres';
    return 'Campo obrigatorio';
  }

  String? get senhaRepeticaoErroMensagem {
    if (senha != null &&
        senhaRepeticao != null &&
        senha != senhaRepeticao.trim()) return 'As senhas são diferentes';
    return null;
  }

//==========STEP 3 Paciente=======================
//=====Variaveis=====

  final _altura = Rx<String?>(null);
  final _peso = Rx<String?>(null);
  //=====Getters e Setters=====
  get altura => this._altura.value;
  setAltura(value) => this._altura.value = value.replaceAll(',', '.');
  get peso => this._peso.value;
  setPeso(value) => this._peso.value = value.replaceAll(',', '.');
  //=====Validações=====

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
  final _descricao = Rx<String?>(null);
  final _especializacao = especializacoes[0].obs;
  //=====Getters e Setters=====
  get descricao => this._descricao.value;
  setDescricao(value) => this._descricao.value = value;
  final descricaoController = TextEditingController();
  get especializacao => this._especializacao.value;
  get especializacaoName => this._especializacao.value.titulo;
  setEspecializacao(value) => this._especializacao.value = value;
  //=====Validações=====

  bool descricaoValido() =>
      descricao != null &&
      descricao.trim().isNotEmpty &&
      descricao.trim().length <= 250;

  String? get descricaoErroMensagem {
    if (descricao == null || descricaoValido()) return null;
    return 'Campo obrigatorio';
  }
//==========STEP 4=======================

  salvarUsuario() {
    EasyLoading.showInfo('Salvando...');
    Map<String, dynamic> dados = {
      'tipo': tipoName,
      'nome': nome,
      'email': email,
      'senha': senha,
      'data_nascimento': '$dataNascimento}',
      'telefone': telefone,
      'fotoPath': foto,
      'ativo': 1,
      'genero': generoName
    };
    if (_id.value != null) dados['id'] = _id.value;
    if (tipo == TipoUsuario.PACIENTE) {
      dados = {
        ...{'cpf': cpf, 'altura': altura, 'peso': peso},
        ...dados
      };
    }

    if (tipo == TipoUsuario.MEDICO) {
      dados = {
        ...{
          'crm': crm,
          'especializacao': especializacao,
          'descricao': descricao
        },
        ...dados
      };
    }
    repository.salvarUsuario(dados).then((retorno) {
      if (!retorno) {
        EasyLoading.instance.backgroundColor = Colors.red;
        EasyLoading.showError('Erro ao cadastrar');
      } else {
        EasyLoading.dismiss();
        Get.offNamed('/');
      }
    });

    EasyLoadingConfig();
  }

  clearTextControllers() {
    setNome(null);
    nomeController.clear();
    setTelefone(null);
    telefoneController.clear();
    setDescricao(null);
    descricaoController.clear();
  }

  validaCRM() {
    if (crm == null) return;
    repository.validaCRM(crm, crmUf).then((retorno) {
      if (retorno is bool) {
        isCrmValid = false;
        clearTextControllers();
      } else {
        isCrmValid = retorno['SITUACAO'] == 'Ativo';
        setNome(retorno['NOME']);
        nomeController.text = nome;
        setTelefone(retorno['TELEFONE']);
        telefoneController.text = telefone;
        setDescricao(retorno['ENDERECO']);
        descricaoController.text = descricao;
      }
    });
  }
}
