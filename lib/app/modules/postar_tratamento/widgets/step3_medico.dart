import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_questao.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/bottom_sheet_opcoes_exclusao_questoes.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/controller_questoes.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/dialog_questoes.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/shimmer_questoes.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/shimmer_select.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:healthbox/core/values/keys.dart';

class Step3MedicoTratamentoPage extends GetView<PostarTratamentoController> {
  const Step3MedicoTratamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => TextFormField(
            initialValue: controller.tituloQuestionario,
            onChanged: controller.setTituloQuestionario,
            decoration: InputDecoration(
                icon: const Icon(
                  Icons.title,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100)),
                labelText: "Título questionário",
                enabledBorder: InputBorder.none,
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                errorText: controller.tituloQuestionarioErroMensagem),
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
          ),
        ),
        Obx(() => Align(
            alignment: Alignment.centerRight,
            child: Text('${controller.tituloQuestionario?.length ?? 0}/50'))),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          initialValue: controller.descricaoQuestionario,
          onChanged: controller.setDescricaoQuestionario,
          maxLines: 5,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.text_fields,
            ),
            border: OutlineInputBorder(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: "Descrição do questionário",
            enabledBorder: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(150),
          ],
        ),
        Obx(() => Align(
            alignment: Alignment.centerRight,
            child:
                Text('${controller.descricaoQuestionario?.length ?? 0}/150'))),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Questões do questionário',
          style: subTitulo,
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.all(5),
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                      context: context,
                      builder: (_) => DialogQuestoes(
                          questao: Questao(tipo: TipoQuestao.D, descricao: '')))
                  .then((val) => Get.find<ControllerQuestoes>().clearFields());
            },
            style: ElevatedButton.styleFrom(primary: Colors.white),
            icon: Icon(
              Icons.add,
              color: corPrincipal,
            ),
            label: const Text(
              'Nova questão',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => controller.carregandoQuestoes
              ? const ShimmerSelects()
              : controller.questoesPreCadastradas.isEmpty
                  ? const AutoSizeText(
                      'Sem questões pre-cadastradas',
                      maxLines: 1,
                    )
                  : DropdownSearch<Questao>(
                      mode: Mode.DIALOG,
                      dropdownSearchDecoration: const InputDecoration(
                        labelText: 'Selecionar questão',
                        isDense: true,
                      ),
                      dropDownButton: Container(),
                      items: controller.questoesPreCadastradas,
                      dropdownButtonBuilder: null,
                      showSearchBox: true,
                      emptyBuilder: (_, __) => const Center(
                        child: Text(
                          'Nenhuma questão foi encontrada.Use o campo de pesquisa acima.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      showClearButton: true,
                      onChanged: (Questao? questao) =>
                          controller.addQuestao(questao!),
                    ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => controller.questoes.isEmpty
              ? const Text('Sem questões cadastradas para esse questionário')
              : Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: controller.carregandoQuestoes
                      ? const ShimmerQuestoes()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.questoes.length,
                          itemBuilder: (_, index) => controller
                                      .questoes[index].tipo ==
                                  TipoQuestao.D
                              ? ListTile(
                                  leading: AutoSizeText(
                                      controller.questoes[index].tipo ==
                                              TipoQuestao.D
                                          ? 'Questão descritiva'
                                          : 'Questão  objetiva',
                                      maxLines: 1),
                                  title: AutoSizeText(
                                      controller.questoes[index].descricao ??
                                          '',
                                      maxLines: 1),
                                  trailing: IconButton(
                                      onPressed: () => showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              BottomSheetOpcoesExclusaoQuestoes(
                                                questao:
                                                    controller.questoes[index],
                                                deletar: () {
                                                  Get.back();
                                                  controller
                                                      .deletarQuestao(index);
                                                },
                                                remover: () {
                                                  Get.back();
                                                  controller.questoes
                                                      .removeAt(index);
                                                },
                                              )),
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      )),
                                )
                              : ExpansionTile(
                                  leading: AutoSizeText(
                                      controller.questoes[index].tipo ==
                                              TipoQuestao.D
                                          ? 'Questão descritiva'
                                          : 'Questão  objetiva',
                                      maxLines: 1),
                                  title: AutoSizeText(
                                      controller.questoes[index].descricao ??
                                          '',
                                      maxLines: 1),
                                  trailing: IconButton(
                                      onPressed: () => showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              BottomSheetOpcoesExclusaoQuestoes(
                                                questao:
                                                    controller.questoes[index],
                                                deletar: () => controller
                                                    .deletarQuestao(index),
                                                remover: () => controller
                                                    .questoes
                                                    .removeAt(index),
                                              )),
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      )),
                                  children: controller.questoes[index].opcoes!
                                      .asMap()
                                      .entries
                                      .map<Text>((entry) => Text(
                                          '${alfabeto[entry.key]}. ${entry.value.descricao}'))
                                      .toList(),
                                )),
                ),
        )
      ],
    );
  }
}
