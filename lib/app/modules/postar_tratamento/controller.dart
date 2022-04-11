import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/repositories/tratamento.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/core/theme/easy_loading_config.dart';
import 'package:healthbox/routes/app_pages.dart';

import '../login/controller.dart';

class PostarTratamentoController extends GetxController {
  final TratamentoRepository repository;
  dynamic usuario;
  final loginController = Get.find<LoginController>();
  PostarTratamentoController({required this.repository})
      : assert(repository != null) {
    usuario = loginController.getLogin();
    doc = Document()..insert(0, ' ');
  }

  @override
  void onInit() {
    super.onInit();
  }

//===============================STEP 1==================================
  final _doc = Rx<Document>(Document()..insert(0, ' '));
  final _texto = Rx<String?>(null);
  final _titulo = Rx<String?>(null);
  final _idOpiniao = Rx<int?>(null);
  final _carregando = false.obs;
  final _eficacia = 1.obs;
  QuillController controller_editor = QuillController.basic();
  final eficazList = <Map<String, dynamic>>[
    {'titulo': 'Eficaz', 'valor': 1},
    {'titulo': 'Ineficaz', 'valor': 0}
  ];
  get idOpiniao => this._idOpiniao.value;
  set idOpiniao(value) => this._idOpiniao.value = value;
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

  bool tituloValido() =>
      titulo != null && editorLength > 10 && editorLength <= 200;

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

  setOpiniaoEdicao(Opiniao opiniao) {
    if (opiniao.pacienteId != usuario.id) {
      Get.offNamed(Routes.INITIAL);
      return;
    }
    idOpiniao = opiniao.id;
    texto = opiniao.descricao;
    doc = Document.fromJson(jsonDecode(texto));
    setEficacia(opiniao.eficaz);
  }

  salvarOpiniao() {
    texto = jsonEncode(controller_editor.document.toDelta().toJson());

    Opiniao opiniao = Opiniao(
        id: idOpiniao,
        descricao: texto,
        pacienteId: usuario.id,
        eficaz: eficacia,
        ativo: 1);
    repository.salvarOpiniao(opiniao).then((retorno) {
      if (retorno) {
        EasyLoading.showSuccess('Opinião salva com sucesso');
        redirectListagem();
      } else {
        EasyLoading.instance.backgroundColor = Colors.red;
        EasyLoading.showError('Erro ao salvar opinião');
        EasyLoadingConfig();
      }
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
