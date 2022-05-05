import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/acompanhamento.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/questionarios/widgets/card_info_questionario.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/questionarios/widgets/card_listagem_questionarios.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/questionarios/widgets/card_postar_resposta.dart';

class QuestionarioPage extends GetView<AcompanhamentosController> {
  late Acompanhamento acompanhamento;
  late int tipo;
  QuestionarioPage({Key? key}) : super(key: key) {
    acompanhamento = Get.arguments['acompanhamento'];
    tipo = Get.arguments['tipo'];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Future.delayed(Duration.zero).then((value) => !controller.carregando),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tipo == 1 ? 'Questionário' : 'Histórico'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CardInfoQuesitonario(acompanhamento: acompanhamento),
              tipo == 1
                  ? CardPostarRespostaPage(
                      questionario: acompanhamento.questionario!)
                  : CardListagemQuestionarios()
            ],
          ),
        ),
      ),
    );
  }
}
