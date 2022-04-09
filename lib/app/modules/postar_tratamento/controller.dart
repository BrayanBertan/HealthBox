import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/repositories/tratamento.dart';

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

  final _doc = Rx<Document>(Document()..insert(0, ' '));
  get doc => this._doc.value;
  set doc(value) => this._doc.value = value;

  final _texto = Rx<String?>(null);
  get texto => this._texto.value;
  set texto(value) => this._texto.value = value;

  final _carregando = false.obs;
  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;

  get editorLength =>
      controller_editor.document.toDelta().toJson()[0]['insert'].length;

  bool TextoValido() =>
      texto != null && editorLength > 10 && editorLength <= 200;

  String? get TextoErroMensagem {
    if (texto == null || TextoValido()) return null;
    if (editorLength > 200) return 'Descrição muito longa';
    return 'Descrição muito curta';
  }

  QuillController controller_editor = QuillController.basic();

  salvarOpiniao() {
    texto = jsonEncode(controller_editor.document.toDelta().toJson());

    Opiniao opiniao =
        Opiniao(descricao: texto, pacienteId: usuario.id, eficaz: 1, ativo: 1);
    repository.salvarOpiniao(opiniao).then((retorno) {});
  }
}
