import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_questao.dart';
import 'package:healthbox/app/data/models/questionario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';

class CustomListQuestionario extends GetView<AcompanhamentosController> {
  Questionario questionario;
  CustomListQuestionario({required this.questionario, Key? key}) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...questionario.questoes!.asMap().entries.map(
              (entry) => Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${entry.key + 1}.${entry.value.descricao ?? ''}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  entry.value.tipo == TipoQuestao.D
                      ? Container(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue:
                                    entry.value.resposta?.respostaDescritiva,
                                decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.title,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade100)),
                                  labelText: entry.value.descricao ?? '',
                                  enabledBorder: InputBorder.none,
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: entry.value.opcoes!
                              .asMap()
                              .entries
                              .map((opcaoEntry) => InkWell(
                                    onTap: () =>
                                        entry.value.resposta?.opcaoId ==
                                        opcaoEntry.value.id!,
                                    child: Container(
                                      height: 35,
                                      child: ListTile(
                                        selectedColor: corPrincipal,
                                        selected: opcaoEntry.value.id! ==
                                            entry.value.resposta?.opcaoId,
                                        title: AutoSizeText(
                                          '(${alfabeto[opcaoEntry.key]}) ${opcaoEntry.value.descricao}',
                                          maxLines: 1,
                                        ),
                                        trailing: Radio<int>(
                                            value: opcaoEntry.value.id!,
                                            groupValue:
                                                entry.value.resposta?.opcaoId ??
                                                    0,
                                            onChanged: null),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )
      ],
    );
  }
}
