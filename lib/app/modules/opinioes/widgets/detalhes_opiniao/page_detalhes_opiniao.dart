import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/card_detalhes_interacoes.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/card_detalhes_medicamentos.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/values/keys.dart';

class PageDetalhesOpiniao extends GetView<OpinioesController> {
  const PageDetalhesOpiniao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da opinião'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (controller.opiniao.paciente?.fotoPath == null)
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('${baseImagemUrl}user_pic.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            else
              CachedNetworkImage(
                imageUrl: controller.opiniao.paciente!.fotoPath,
                imageBuilder: (context, imageProvider) => Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                    child: const CircleAvatar(
                      maxRadius: 45,
                      minRadius: 45,
                    ),
                    baseColor: corPrincipal50,
                    highlightColor: corPrincipal),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Postado em ${controller.opiniao?.dataPostagem ?? ''}',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Atualizado em ${controller.opiniao?.dataAtualizacao ?? ''}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              '${controller.opiniao?.paciente?.nome ?? ''}',
              style: subTitulo,
              textAlign: TextAlign.center,
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
                Container(
                    padding: const EdgeInsets.all(1),
                    width: 30,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        color: controller.opiniao.eficaz == 1
                            ? Colors.green
                            : Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular((5)))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller
                          .getEficacia(controller.opiniao.eficaz)
                          .map((texto) => texto)
                          .toList(),
                    ))
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
