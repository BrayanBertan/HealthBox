import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

class ItemListQuestionariosCalendar extends GetView<AcompanhamentosController> {
  int index;
  ItemListQuestionariosCalendar({required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => controller
                .getInfoAcompanhamento(controller
                    .questionariosSelecionados[index].acompanhamentoId)
                .then((retorno) {
              if (retorno != null) {
                Get.toNamed(Routes.DETALHES_TRATAMENTO, arguments: retorno);
              }
            }),
        leading: controller.questionariosSelecionados[index].usuarioVinculado
                    ?.fotoPath ==
                null
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
                imageUrl: controller.questionariosSelecionados[index]
                    .usuarioVinculado!.fotoPath!,
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
        title: Text(controller.questionariosSelecionados[index].titulo),
        trailing: controller.getHistoricoLegenda(controller
                        .questionariosSelecionados[index]
                        .dataResposta!)['disponivel'] ==
                    0 ||
                controller.usuario.tipo == TipoUsuario.MEDICO
            ? Obx(() => controller.carregandoInfoAcompanhamento
                ? const CircularProgressIndicator()
                : TextButton.icon(
                    onPressed: () {
                      controller.carregandoInfoAcompanhamento = true;
                      controller
                          .getInfoAcompanhamento(controller
                              .questionariosSelecionados[index]
                              .acompanhamentoId)
                          .then((retorno) {
                        controller.carregandoInfoAcompanhamento = false;
                        if (retorno != null) {
                          controller.getQuestionarios(
                              idAcompanhamento: controller
                                  .questionariosSelecionados[index]
                                  .acompanhamentoId);

                          Get.toNamed(Routes.QUESTIONARIO_ACOMPANHAMENTOS,
                              arguments: {
                                'acompanhamento': retorno,
                                'tipo': 2
                              });
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.list_alt_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Visualizar',
                      style: TextStyle(color: Colors.black),
                    )))
            : controller.usuario.tipo == TipoUsuario.PACIENTE
                ? Obx(() => controller.carregandoInfoAcompanhamento
                    ? const CircularProgressIndicator()
                    : TextButton.icon(
                        onPressed: controller.getHistoricoLegenda(controller
                                    .questionariosSelecionados[index]
                                    .dataResposta!)['disponivel'] ==
                                2
                            ? null
                            : () {
                                controller.carregandoInfoAcompanhamento = true;
                                controller
                                    .getInfoAcompanhamento(controller
                                        .questionariosSelecionados[index]
                                        .acompanhamentoId)
                                    .then((retorno) {
                                  controller.carregandoInfoAcompanhamento =
                                      false;
                                  if (retorno != null) {
                                    Get.toNamed(
                                        Routes.QUESTIONARIO_ACOMPANHAMENTOS,
                                        arguments: {
                                          'acompanhamento': retorno,
                                          'tipo': 1
                                        });
                                  }
                                });
                              },
                        icon: Icon(
                          Icons.edit,
                          color: controller.getHistoricoLegenda(controller
                                      .questionariosSelecionados[index]
                                      .dataResposta!)['disponivel'] ==
                                  2
                              ? Colors.grey
                              : Colors.black,
                        ),
                        label: Text(
                          'Responder',
                          style: TextStyle(
                              color: controller.getHistoricoLegenda(controller
                                          .questionariosSelecionados[index]
                                          .dataResposta!)['disponivel'] ==
                                      2
                                  ? Colors.grey
                                  : Colors.black),
                        )))
                : Container(
                    width: 0,
                    height: 0,
                  ));
  }
}
