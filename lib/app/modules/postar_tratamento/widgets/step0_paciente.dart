import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/acompanhamento.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/shimmer_select.dart';
import 'package:healthbox/app/widgets/detalhes_tratamento/card_detalhes_medicamentos.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class Step0PacienteTratamentoPage extends GetView<PostarTratamentoController> {
  const Step0PacienteTratamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: controller.idPostagem != null,
      child: Column(
        children: [
          const Text(
            'Você pode preencher os dados manualmente ou importar dos seus acompanhamentos',
            style: subTitulo,
            textAlign: TextAlign.center,
          ),
          Obx(
            () => controller.carregandoMeusAcompanhamento
                ? const ShimmerSelects()
                : controller.meusAcompanhamentos.isEmpty
                    ? const Text('Sem acompanhamentos disponiveis')
                    : DropdownSearch<Acompanhamento>(
                        mode: Mode.DIALOG,
                        dropdownSearchDecoration: const InputDecoration(
                          labelText: 'Selecionar o acompanhamento',
                          isDense: true,
                        ),
                        dropDownButton: Container(),
                        items: controller.meusAcompanhamentos,
                        dropdownButtonBuilder: null,
                        showSearchBox: true,
                        emptyBuilder: (_, __) => const Center(
                          child: Text(
                            'Nenhum acompanhamento foi encontrado.Use o campo de pesquisa acima.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        showClearButton: true,
                        onChanged: controller.setmeuAcompanhamento,
                      ),
          ),
          Obx(() => Text(
                controller.vinculoErroMensagem ?? '',
                style: const TextStyle(color: Colors.red),
              )),
          const SizedBox(
            height: 10,
          ),
          Obx(() => Column(
                children: controller.acompanhamento == null
                    ? const [
                        Text(
                          'Nenhum acompanhamento selecionado',
                          style: subTitulo,
                          textAlign: TextAlign.center,
                        )
                      ]
                    : [
                        const Text(
                          'Dados do acompanhamento selecionado',
                          style: subTitulo,
                          textAlign: TextAlign.center,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  controller
                                          .acompanhamento.tratamento?.titulo ??
                                      '',
                                  style: titulo,
                                ),
                                QuillEditor(
                                  controller: QuillController(
                                      document: Document.fromJson(jsonDecode(
                                          controller.acompanhamento.tratamento
                                              .descricao)),
                                      selection: const TextSelection.collapsed(
                                          offset: 0)),
                                  scrollController: ScrollController(),
                                  scrollable: true,
                                  focusNode: FocusNode(),
                                  minHeight:
                                      MediaQuery.of(context).size.height * 0.2,
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.2,
                                  autoFocus: false,
                                  readOnly: true,
                                  enableInteractiveSelection: false,
                                  expands: false,
                                  padding: const EdgeInsets.all(5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(() => controller.acompanhamento.tratamento
                                        ?.medicamentos ==
                                    null ||
                                controller.acompanhamento.tratamento
                                    .medicamentos.isEmpty
                            ? const Card(
                                child: Text(
                                    'Sem medicamentos cadastrados para esse acompanhamento'),
                              )
                            : CardDetalhesMedicamentos(
                                medicamentos: controller
                                    .acompanhamento.tratamento.medicamentos)),
                      ],
              ))
        ],
      ),
    );
  }
}
