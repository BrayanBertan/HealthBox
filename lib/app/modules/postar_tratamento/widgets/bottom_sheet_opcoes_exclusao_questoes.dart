import 'package:flutter/material.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class BottomSheetOpcoesExclusaoQuestoes extends StatelessWidget {
  Questao questao;
  void Function() deletar;
  void Function() remover;
  BottomSheetOpcoesExclusaoQuestoes(
      {required this.questao,
      required this.deletar,
      required this.remover,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  questao.descricao ?? '',
                  style: subTitulo,
                ),
                TextButton(
                    onPressed: deletar,
                    child: const Text(
                      'Deletar questão do pré-cadastro',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: remover,
                    child: const Text(
                      'Remover questão desse questionário',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ));
  }
}
