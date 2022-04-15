import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/sub_controllers/controller_interacoes.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:like_button/like_button.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/values/keys.dart';

class InteracoesItemListOpiniao extends GetWidget<InteracaoController> {
  int index;
  final controllerOpinioes = Get.find<OpinioesController>();
  InteracoesItemListOpiniao({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLiked = controllerOpinioes
        .inicializaLikes(controllerOpinioes.opinioes[index].likes);
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          height: 40,
          color: corPrincipal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Obx(
                    () => LikeButton(
                      onTap: (isLike) async {
                        if (!isLike) {
                          if (controller.isLiked == 0)
                            controllerOpinioes.opinioes[index].totalDislike--;
                          controller.isLiked = 1;
                          controllerOpinioes
                              .setLike(
                                  true,
                                  controllerOpinioes.opinioes[index].id!,
                                  controllerOpinioes.opinioes[index].likes)
                              .then((retorno) {
                            if (controllerOpinioes
                                .listaLikesAtualizada.isNotEmpty) {
                              controllerOpinioes.opinioes[index].likes
                                  .assignAll(
                                      controllerOpinioes.listaLikesAtualizada);
                            }
                          });

                          controllerOpinioes.opinioes[index].totalLike++;
                        } else {
                          controllerOpinioes.deleteLike(
                              controllerOpinioes.opinioes[index].likes);

                          controllerOpinioes.opinioes[index].likes.removeWhere(
                              (element) =>
                                  element.idUsuario ==
                                  controllerOpinioes.usuario.id);
                        }
                        await Future.delayed(const Duration(milliseconds: 250));
                        return !isLike;
                      },
                      isLiked: controller.isLiked == 1,
                      circleColor: CircleColor(
                          start: Colors.green.withOpacity(0.5),
                          end: Colors.green.withOpacity(0.3)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Colors.green.withOpacity(0.7),
                        dotSecondaryColor: Colors.green,
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.thumb_up_outlined,
                          color: isLiked ? Colors.green : Colors.black87,
                        );
                      },
                      likeCount:
                          controllerOpinioes.opinioes[index].totalLike >= 0
                              ? controllerOpinioes.opinioes[index].totalLike
                              : 0,
                      countBuilder: (int? count, bool isLiked, String text) {
                        var color = isLiked ? Colors.green : Colors.black87;
                        return Text(
                          text,
                          style: TextStyle(color: color),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Obx(
                    () => LikeButton(
                      onTap: (isLike) async {
                        if (!isLike) {
                          if (controller.isLiked == 1)
                            controllerOpinioes.opinioes[index].totalLike--;
                          controller.isLiked = 0;
                          controllerOpinioes
                              .setLike(
                                  false,
                                  controllerOpinioes.opinioes[index].id!,
                                  controllerOpinioes.opinioes[index].likes)
                              .then((retorno) {
                            if (controllerOpinioes
                                .listaLikesAtualizada.isNotEmpty) {
                              controllerOpinioes.opinioes[index].likes
                                  .assignAll(
                                      controllerOpinioes.listaLikesAtualizada);
                            }
                          });
                          controllerOpinioes.opinioes[index].totalDislike++;
                        } else {
                          controllerOpinioes.deleteLike(
                              controllerOpinioes.opinioes[index].likes);
                          controllerOpinioes.opinioes[index].likes.removeWhere(
                              (element) =>
                                  element.idUsuario ==
                                  controllerOpinioes.usuario.id);
                        }

                        await Future.delayed(const Duration(milliseconds: 250));
                        return !isLike;
                      },
                      isLiked: controller.isLiked == 0,
                      circleColor: CircleColor(
                          start: Colors.red.withOpacity(0.5),
                          end: Colors.red.withOpacity(0.3)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Colors.red.withOpacity(0.7),
                        dotSecondaryColor: Colors.red,
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.thumb_down_alt_outlined,
                          color: isLiked ? Colors.red : Colors.black87,
                        );
                      },
                      likeCount:
                          controllerOpinioes.opinioes[index].totalDislike >= 0
                              ? controllerOpinioes.opinioes[index].totalDislike
                              : 0,
                      countBuilder: (int? count, bool isLiked, String text) {
                        var color = isLiked ? Colors.red : Colors.black87;
                        return Text(
                          text,
                          style: TextStyle(color: color),
                        );
                      },
                    ),
                  ),
                ],
              ),
              controllerOpinioes.isMinhasOpinoesChecked
                  ? TextButton.icon(
                      onPressed: () => Get.toNamed(Routes.POSTAR_TRATAMENTO,
                          arguments: controllerOpinioes.opinioes[index]),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black87,
                      ),
                      label: const Text(
                        'Editar',
                        style: TextStyle(color: Colors.black87),
                      ))
                  : Container(),
              InkWell(
                onTap: () {
                  controllerOpinioes.opiniao =
                      controllerOpinioes.opinioes[index];
                  FocusScope.of(context).unfocus();
                  Get.toNamed(Routes.DETALHES_OPINIAO)!.then((value) {
                    controllerOpinioes.getOpinioes();
                    FocusScope.of(context).unfocus();
                  });
                },
                child: Row(
                  children: [
                    Image.asset('${baseImagemUrl}details.png', width: 25),
                    const SizedBox(
                      width: 2,
                    ),
                    const Text('Detalhes')
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
