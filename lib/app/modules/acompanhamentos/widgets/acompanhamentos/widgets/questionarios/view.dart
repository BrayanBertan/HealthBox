import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/questionario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/questionarios/widgets/card_info_questionario.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/questionarios/widgets/card_postar_resposta.dart';

class QuestionarioPage extends GetView<AcompanhamentosController> {
  Questionario? questionario;
  int? tipo;
  QuestionarioPage({Key? key}) : super(key: key) {
    questionario = Get.arguments['questionario'];
    tipo = Get.arguments['tipo'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionário'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CardInfoQuesitonario(questionario: questionario!),
            tipo == 1
                ? CardPostarRespostaPage(questionario: questionario!)
                : Container()
          ],
        ),
      ),
    );
  }
}
