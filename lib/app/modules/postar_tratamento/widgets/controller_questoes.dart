import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_questao.dart';
import 'package:healthbox/app/data/models/opcao_questao.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';

class ControllerQuestoes extends GetxController {
  List<OpcaoQuestao> opcoesQuestao = <OpcaoQuestao>[].obs;

  final _descricaoQuestao = Rx<String?>(null);
  final _tipo = TipoQuestao.D.obs;
  final _descricaoOpcao = Rx<String?>(null);
  final _isOpcoesUntouched = true.obs;

  final descricaoOpcaController = TextEditingController();

  get descricaoQuestao => this._descricaoQuestao.value;
  setDescricaoQuestao(value) => this._descricaoQuestao.value = value;
  get tipo => this._tipo.value;
  setTipo(value) => this._tipo.value = value;
  get descricaoOpcao => this._descricaoOpcao.value;
  setDescricaoOpcao(value) => this._descricaoOpcao.value = value;
  get isOpcoesUntouched => this._isOpcoesUntouched.value;
  set isOpcoesUntouched(value) => this._isOpcoesUntouched.value = value;

  bool descricaoQuestaoValido() =>
      descricaoQuestao != null &&
      descricaoQuestao.isNotEmpty &&
      descricaoQuestao.trim().length >= 5;

  String? get descricaoQuestaoErroMensagem {
    if (descricaoQuestao == null || descricaoQuestaoValido()) return null;
    if (descricaoQuestao.trim().length < 5) return 'Descrição muito curta';
    return 'Campo obrigatório';
  }

  bool descricaoOpcaoValido() =>
      descricaoOpcao != null &&
      descricaoOpcao.isNotEmpty &&
      descricaoOpcao.trim().length >= 5;

  String? get descricaoOpcaoErroMensagem {
    if (descricaoOpcao == null || descricaoOpcaoValido()) return null;
    if (descricaoOpcao.trim().length < 5) return 'Descrição muito curta';
    return 'Campo obrigatório';
  }

  bool opcoesQuestaoValido() => opcoesQuestao.length >= 2;

  String? get opcoesQuestaoErroMensagem {
    if (isOpcoesUntouched || opcoesQuestaoValido()) return null;
    if (opcoesQuestao.length < 2) {
      return 'A questão precisa ter pelo menos 2 opções';
    }
  }

  bool formValido() =>
      descricaoQuestaoValido() &&
      (tipo == TipoQuestao.D || opcoesQuestaoValido());

  addOpcao() {
    isOpcoesUntouched = false;

    final opcaoQuestao = OpcaoQuestao(descricao: descricaoOpcao);

    if (opcoesQuestao
        .where((param) => param.descricao == opcaoQuestao.descricao)
        .isNotEmpty) {
      EasyLoading.showToast(
          'Já existe uma opção de resposta com essa descrição',
          duration: const Duration(milliseconds: 500),
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    descricaoOpcaController.clear();
    opcoesQuestao.add(OpcaoQuestao(descricao: descricaoOpcao));
  }

  clearFields() {
    opcoesQuestao.clear();
    setTipo(TipoQuestao.D);
    setDescricaoQuestao(null);
    setDescricaoOpcao(null);
    isOpcoesUntouched = true;
  }

  salvarInfo() {
    Questao questao = Questao(
      tipo: tipo,
      descricao: descricaoQuestao,
      utilizado: false,
    );
    questao.opcoes = List.from(opcoesQuestao);

    if (questao.tipo == TipoQuestao.D) questao.opcoes = null;

    final controller = Get.find<PostarTratamentoController>();

    controller.addQuestao(questao);

    Get.back();
  }
}
