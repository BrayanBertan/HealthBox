import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/questionarios_acompanhamento/widgets/filtros/card_pesquisa.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/questionarios_acompanhamento/widgets/filtros/card_questionarios.dart';

class QuestionariosAcompanhamentosPage extends StatelessWidget {
  const QuestionariosAcompanhamentosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [CardPesquisa(), CardQuestionarios()],
        ),
      ),
    );
  }
}
