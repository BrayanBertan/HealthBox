import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_questao.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/app/data/models/questionario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';

class CardPostarRespostaPage extends GetView<AcompanhamentosController> {
  Questionario questionario;
  CardPostarRespostaPage({required this.questionario, Key? key})
      : super(key: key) {
    print('questionario ${questionario.questoes![2].resposta}');
    controller
        .setCamposRespostas(questionario.questoes ?? List<Questao>.empty());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          ...questionario.questoes!.asMap().entries.map((entry) => Column(
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
                              Obx(
                                () => TextFormField(
                                  initialValue: controller
                                      .camposRespostas[entry.key].value,
                                  onChanged: (value) => controller
                                      .camposRespostas[entry.key].value = value,
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
                                      errorText:
                                          controller.isCampoValido(entry.key)),
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
                                    onTap: () => controller
                                        .camposRespostas[entry.key]
                                        .value = opcaoEntry.value.id!,
                                    child: Container(
                                      height: 35,
                                      child: Obx(
                                        () => ListTile(
                                          selectedColor: corPrincipal,
                                          selected: opcaoEntry.value.id! ==
                                              controller
                                                  .camposRespostas[entry.key]
                                                  .value,
                                          title: AutoSizeText(
                                            '(${alfabeto[opcaoEntry.key]}) ${opcaoEntry.value.descricao}',
                                            maxLines: 1,
                                          ),
                                          trailing: Obx(
                                            () => Radio<int>(
                                                value: opcaoEntry.value.id!,
                                                groupValue: controller
                                                    .camposRespostas[entry.key]
                                                    .value,
                                                onChanged: (value) => controller
                                                    .camposRespostas[entry.key]
                                                    .value = value),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Obx(() => ElevatedButton(
              onPressed: controller.isFormValido()
                  ? () => controller.salvarQuestionario(questionario.id!,
                      questionario.questoes ?? List<Questao>.empty())
                  : null,
              style: ElevatedButton.styleFrom(
                  onSurface: corPrincipal300, fixedSize: const Size(150, 50)),
              child: const Text('Salvar')))
        ]),
      ),
    );
  }
}
