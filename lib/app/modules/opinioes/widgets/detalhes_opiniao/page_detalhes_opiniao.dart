import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/card_detalhes_interacoes.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/card_detalhes_medicamentos.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../../../../core/values/keys.dart';

class PageDetalhesOpiniao extends GetView<OpinioesController> {
  const PageDetalhesOpiniao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 100.0,
              child: Image.asset('${baseImagemUrl}user_pic.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${controller.opiniao.tratamento!.titulo}',
              style: titulo,
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Expanded(
                    child: Card(
                  child: QuillEditor(
                    controller: QuillController(
                        document: Document.fromJson(
                            jsonDecode(controller.opiniao.descricao)),
                        selection: const TextSelection.collapsed(offset: 0)),
                    scrollController: ScrollController(),
                    scrollable: true,
                    focusNode: FocusNode(),
                    minHeight: MediaQuery.of(context).size.height * 0.3,
                    maxHeight: MediaQuery.of(context).size.height * 0.3,
                    autoFocus: false,
                    readOnly: true,
                    enableInteractiveSelection: false,
                    expands: false,
                    padding: const EdgeInsets.all(5),
                  ),
                )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.opiniao.eficaz == 1
                        ? Container(
                            padding: const EdgeInsets.all(1),
                            width: 30,
                            height: 155,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular((5)))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controller
                                  .getEficacia(1)
                                  .map((texto) => texto)
                                  .toList(),
                            ))
                        : Container(
                            padding: const EdgeInsets.all(1),
                            width: 30,
                            height: 155,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular((5)))),
                          ),
                    const SizedBox(
                      height: 5,
                    ),
                    controller.opiniao.eficaz == 0
                        ? Container(
                            padding: const EdgeInsets.all(1),
                            width: 30,
                            height: 155,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular((5)))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controller
                                  .getEficacia(0)
                                  .map((texto) => texto)
                                  .toList(),
                            ))
                        : Container(
                            padding: const EdgeInsets.all(1),
                            width: 30,
                            height: 155,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular((5)))),
                          ),
                  ],
                )
              ],
            ),
            Text(
              'Descrição do tratamento',
              style: subTitulo,
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.1,
                child: Text(
                  controller.opiniao.tratamento.descricao,
                ),
              ),
            ),
            CardDetalhesMedicamentos(
                medicamentos: controller.opiniao.tratamento?.medicamentos ??
                    List<MedicamentoInfo>.empty()),
            CardDetalhesInteracoes(opiniao: controller.opiniao),
          ],
        ),
      ),
    );
  }
}
