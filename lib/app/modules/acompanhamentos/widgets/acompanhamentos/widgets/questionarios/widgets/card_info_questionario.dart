import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/questionario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class CardInfoQuesitonario extends GetView<AcompanhamentosController> {
  Questionario questionario;
  CardInfoQuesitonario({required this.questionario, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AutoSizeText(
              questionario.titulo,
              style: titulo,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            AutoSizeText(
              questionario.descricao ?? '',
              style: subTitulo,
              maxLines: 5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
