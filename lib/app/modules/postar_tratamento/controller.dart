import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/models/tratamento.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
import 'package:healthbox/app/data/providers/conta.dart';
import 'package:healthbox/app/data/repositories/conta.dart';
import 'package:healthbox/app/data/repositories/tratamento.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/core/theme/easy_loading_config.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../login/controller.dart';

class PostarTratamentoController extends GetxController {
  final TratamentoRepository repository;
  dynamic usuario;
  final loginController = Get.find<LoginController>();
  PostarTratamentoController({required this.repository})
      : assert(repository != null) {
    usuario = loginController.getLogin();
    isPaciente = usuario.tipo == TipoUsuario.PACIENTE;
    if (!isPaciente) {
      getVinculos();
    }
    doc = Document()..insert(0, ' ');
  }

  @override
  void onInit() {
    super.onInit();
  }

  //======================TODOS==========================================
  final _activeStepIndex = 0.obs;
  final _isPaciente = false.obs;
  get isPaciente => this._isPaciente.value;
  set isPaciente(value) => this._isPaciente.value = value;
  get activeStepIndex => this._activeStepIndex.value;
  setActiveStepIndex(value) => this._activeStepIndex.value =
      isValidStep(activeStepIndex) || value < activeStepIndex
          ? value
          : activeStepIndex;
  activeStepIndexIncrease() => this._activeStepIndex.value++;
  activeStepIndexDecrease() => this._activeStepIndex.value--;

  bool isValidStep(int step) {
    bool retorno = false;
    if (isPaciente) {
      switch (step) {
        case 0:
          retorno = step1Valido();
          break;
        case 1:
          retorno = step2PacienteValido();
          break;
        case 2:
          retorno = step3PacienteValido();
          break;
        default:
          retorno = step1Valido();
      }
    } else {}

    return retorno;
  }

  StepState getStepState(int step) {
    if (step == activeStepIndex) return StepState.editing;
    if (step != activeStepIndex && isValidStep(step)) return StepState.complete;
    if (step != activeStepIndex && !isValidStep(step)) return StepState.indexed;
    return StepState.indexed;
  }

//===============================STEP 1==================================
  final _doc = Rx<Document>(Document()..insert(0, ' '));
  final _texto = Rx<String?>(null);
  final _titulo = Rx<String?>(null);
  final _idOpiniao = Rx<int?>(null);
  final _idTratamento = Rx<int?>(null);
  final _carregando = false.obs;
  final _eficacia = 1.obs;
  QuillController controller_editor = QuillController.basic();
  final eficazList = <Map<String, dynamic>>[
    {'titulo': 'Eficaz', 'valor': 1},
    {'titulo': 'Ineficaz', 'valor': 0}
  ];
  FocusNode tituloFocus = FocusNode();
  get idOpiniao => this._idOpiniao.value;
  set idOpiniao(value) => this._idOpiniao.value = value;
  get idTratamento => this._idTratamento.value;
  set idTratamento(value) => this._idTratamento.value = value;
  get doc => this._doc.value;
  set doc(value) => this._doc.value = value;
  get titulo => this._titulo.value;
  setTitulo(value) => this._titulo.value = value;
  get texto => this._texto.value;
  set texto(value) => this._texto.value = value;
  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;
  get eficacia => this._eficacia.value;
  setEficacia(value) => this._eficacia.value = value;
  get editorLength =>
      controller_editor.document.toDelta().toJson()[0]['insert'].length;

  bool step1Valido() => textoValido() && tituloValido();

  bool tituloValido() => titulo != null && titulo.isNotEmpty;

  String? get tituloErroMensagem {
    if (titulo == null || tituloValido()) return null;
    return 'Campo obrigatório';
  }

  bool textoValido() =>
      texto != null && editorLength > 10 && editorLength <= 200;

  String? get textoErroMensagem {
    if (texto == null || textoValido()) return null;
    if (editorLength > 200) return 'Descrição muito longa';
    return 'Descrição muito curta';
  }

  //===============================STEP 2==================================

  final medicamentosSelecionadosInfo = <MedicamentoInfo>[].obs;
  Future<List<Medicamento>> getMedicamentos(String? filtro) async {
    if (filtro == null) return List<Medicamento>.empty();
    return await repository.getMedicamentosFiltro(filtro);
  }

  final _descricao = ''.obs;
  get descricao => this._descricao.value;
  setDescricao(value) => this._descricao.value = value;

  bool medicamentosSelecionadosValid() =>
      medicamentosSelecionadosInfo.where((item) => item.dose.isEmpty).length <=
      0;

  bool step2PacienteValido() => medicamentosSelecionadosValid();

  //==================STEP 3========================================

  bool step3PacienteValido() => step1Valido() && step2PacienteValido();
  //==================STEP 4========================================
  final vinculos = <Vinculo>[].obs;
  final _dataInicial = Rx<DateTime?>(null);
  final _carregandoVinculos = false.obs;
  final _paciente = Rx<Vinculo?>(null);
  final _quantidadePeriodicidade = Rx<String?>(null);
  final _diasDuracao = Rx<String?>(null);

  get carregandoVinculos => this._carregandoVinculos.value;
  set carregandoVinculos(value) => this._carregandoVinculos.value = value;
  String get formataDataInicial => dataInicial == null
      ? DateFormat('dd/MM/yyyy').format(DateTime.now())
      : DateFormat('dd/MM/yyyy').format(dataInicial);
  get paciente => this._paciente.value;
  set paciente(value) => this._paciente.value = value;

  get dataInicial => this._dataInicial.value;
  set dataInicial(value) => this._dataInicial.value = value;

  get quantidadePeriodicidade => this._quantidadePeriodicidade.value;
  setQuantidadePeriodicidade(value) =>
      this._quantidadePeriodicidade.value = value;

  get diasDuracao => this._diasDuracao.value;
  setDiasDuracao(value) => this._diasDuracao.value = value;

  getVinculos() {
    carregandoVinculos = true;
    ContaRepository(provider: ContaProvider()).getVinculos(1).then((retorno) {
      vinculos.clear();
      vinculos.assignAll(retorno);
      carregandoVinculos = false;
    });
  }

  // =====================================================================================
  setOpiniaoEdicao(Opiniao opiniao) {
    if (opiniao.pacienteId != usuario.id) {
      Get.offNamed(Routes.INITIAL);
      return;
    }

    idTratamento = opiniao.tratamento!.id;
    idOpiniao = opiniao.id;
    texto = opiniao.descricao;
    doc = Document.fromJson(jsonDecode(texto));
    setTitulo(opiniao.tratamento?.titulo ?? '');
    medicamentosSelecionadosInfo.clear();
    medicamentosSelecionadosInfo.assignAll(
        opiniao.tratamento?.medicamentos ?? List<MedicamentoInfo>.empty());
    setEficacia(opiniao.eficaz);
    setDescricao(opiniao.tratamento?.descricao ?? '');
  }

  salvarOpiniao() {
    EasyLoading.showInfo('Salvando...', duration: const Duration(days: 1));

    texto = jsonEncode(controller_editor.document.toDelta().toJson());

    Opiniao opiniao = Opiniao(
        descricao: texto, pacienteId: usuario.id, eficaz: eficacia, ativo: 1);
    if (idOpiniao != null) opiniao.id = idOpiniao;
    repository.salvarOpiniao(opiniao).then((retorno) {
      if (retorno == null || retorno is bool) {
        EasyLoading.instance.backgroundColor = Colors.red;
        EasyLoading.showError('Erro ao salvar opinião');
        EasyLoadingConfig();
      } else {
        Tratamento tratamento = Tratamento(
            titulo: titulo,
            descricao: descricao,
            opiniaoId: retorno,
            medicamentos: medicamentosSelecionadosInfo);
        if (idTratamento != null) tratamento.id = idTratamento;

        repository.salvarTratamento(tratamento).then((retorno1) {
          if (retorno1) {
            EasyLoading.showSuccess('Opinião salva com sucesso');
            EasyLoadingConfig();
            redirectListagem();
          } else {
            EasyLoading.instance.backgroundColor = Colors.red;
            EasyLoading.showError('Erro ao salvar opinião');
            EasyLoadingConfig();
          }
          EasyLoading.dismiss();
        });
      }
      EasyLoading.dismiss();
    });
  }

  deletarOpiniao() {
    repository.deletarOpiniao(idOpiniao).then((retorno) {
      if (retorno) {
        EasyLoading.showToast('Opinião deletada com sucesso',
            toastPosition: EasyLoadingToastPosition.bottom);
        redirectListagem();
      } else {
        EasyLoading.showToast('Erro ao deletar  Opinião',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }

  redirectListagem() {
    Get.find<OpinioesController>().getOpinioes();
    Get.offNamed(Routes.INITIAL);
  }
}
