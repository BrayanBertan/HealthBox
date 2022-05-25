import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/acompanhamento.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CardInfoQuesitonario extends GetView<AcompanhamentosController> {
  Acompanhamento acompanhamento;
  CardInfoQuesitonario({required this.acompanhamento, Key? key})
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
            Obx(() => controller.questionariosVisualizacao.isEmpty
                ? Container()
                : StepProgressIndicator(
                    totalSteps: controller.questionariosVisualizacao.length,
                    currentStep: 4,
                    size: 30,
                    selectedColor: corPrincipal,
                    unselectedColor: Colors.grey[200]!,
                    customStep: (index, color, _) =>
                        controller.getStepContainer(
                            controller.questionariosVisualizacao[index]))),
            ListTile(
              leading: acompanhamento.medico?.fotoPath == null
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: AssetImage('${baseImagemUrl}user_pic.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: acompanhamento.medico!.fotoPath!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                          child: const CircleAvatar(
                            maxRadius: 20,
                            minRadius: 20,
                          ),
                          baseColor: corPrincipal50,
                          highlightColor: corPrincipal),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
              title: Text('Médico ${acompanhamento.medico?.nome ?? ''}'),
            ),
            ListTile(
              leading: acompanhamento.paciente?.fotoPath == null
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: AssetImage('${baseImagemUrl}user_pic.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: acompanhamento.paciente!.fotoPath!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                          child: const CircleAvatar(
                            maxRadius: 20,
                            minRadius: 20,
                          ),
                          baseColor: corPrincipal50,
                          highlightColor: corPrincipal),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
              title: Text('Paciente ${acompanhamento.paciente?.nome ?? ''}'),
            ),
            AutoSizeText(
              acompanhamento.tratamento?.titulo ?? '',
              style: titulo,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            QuillEditor(
              controller: QuillController(
                  document: Document.fromJson(
                      jsonDecode(acompanhamento.tratamento!.descricao)),
                  selection: const TextSelection.collapsed(offset: 0)),
              scrollController: ScrollController(),
              scrollable: true,
              focusNode: FocusNode(),
              minHeight: MediaQuery.of(context).size.height * 0.15,
              maxHeight: MediaQuery.of(context).size.height * 0.15,
              autoFocus: false,
              readOnly: true,
              enableInteractiveSelection: false,
              expands: false,
              padding: const EdgeInsets.all(5),
            ),
            TextButton.icon(
                onPressed: () => Get.toNamed(Routes.DETALHES_TRATAMENTO,
                    arguments: acompanhamento),
                icon: const Icon(Icons.list_alt_outlined),
                label: const Text('Detalhes do tratamento')),
          ],
        ),
      ),
    );
  }
}
