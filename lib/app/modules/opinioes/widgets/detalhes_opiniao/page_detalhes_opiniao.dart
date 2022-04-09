import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/card_detalhes_interacoes.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/card_detalhes_medicamentos.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../../../../core/values/keys.dart';

class PageDetalhesOpiniao extends GetView<OpinioesController> {
  PageDetalhesOpiniao({Key? key}) : super(key: key);

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
              'Nomeeeeee',
              style: titulo,
              textAlign: TextAlign.center,
            ),
            Card(
              child: IgnorePointer(
                ignoring: true,
                child: QuillEditor(
                  controller: QuillController(
                      document: Document.fromJson(jsonDecode(
                          controller.opinioes[Get.arguments].descricao)),
                      selection: const TextSelection.collapsed(offset: 0)),
                  scrollController: ScrollController(),
                  scrollable: false,
                  focusNode: FocusNode(),
                  autoFocus: false,
                  readOnly: true,
                  expands: false,
                  padding: const EdgeInsets.all(5),
                ),
              ),
            ),
            CardDetalhesMedicamentos(),
            CardDetalhesInteracoes(),
          ],
        ),
      ),
    );
  }
}
