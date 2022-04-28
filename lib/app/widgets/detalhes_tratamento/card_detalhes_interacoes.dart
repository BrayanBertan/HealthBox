import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/sub_controllers/controller_interacoes.dart';
import 'package:like_button/like_button.dart';

import '../../../../../routes/app_pages.dart';

class CardDetalhesInteracoes extends GetWidget<InteracaoController> {
  Opiniao opiniao;
  final controllerOpinioes = Get.find<OpinioesController>();
  CardDetalhesInteracoes({required this.opiniao, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLiked = controllerOpinioes.inicializaLikes(opiniao.likes);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      child: Align(
        alignment: Alignment.center,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: controllerOpinioes.usuario.id == opiniao.pacienteId
                  ? 250
                  : 150,
              height: 65,
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
                                opiniao.totalDislike--;
                              controller.isLiked = 1;
                              controllerOpinioes
                                  .setLike(true, opiniao.id!, opiniao.likes)
                                  .then((retorno) {
                                if (controllerOpinioes
                                    .listaLikesAtualizada.isNotEmpty) {
                                  opiniao.likes.assignAll(
                                      controllerOpinioes.listaLikesAtualizada);
                                }
                              });
                              opiniao.totalLike++;
                            } else {
                              controllerOpinioes.deleteLike(opiniao.likes);
                              opiniao.likes.removeWhere((element) =>
                                  element.idUsuario ==
                                  controllerOpinioes.usuario.id);
                            }
                            await Future.delayed(
                                const Duration(milliseconds: 250));
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
                              opiniao.totalLike >= 0 ? opiniao.totalLike : 0,
                          countBuilder:
                              (int? count, bool isLiked, String text) {
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
                              if (controller.isLiked == 1) opiniao.totalLike--;
                              controller.isLiked = 0;
                              controllerOpinioes
                                  .setLike(false, opiniao.id!, opiniao.likes)
                                  .then((retorno) {
                                if (controllerOpinioes
                                    .listaLikesAtualizada.isNotEmpty) {
                                  opiniao.likes.assignAll(
                                      controllerOpinioes.listaLikesAtualizada);
                                }
                              });
                              opiniao.totalDislike++;
                            } else {
                              controllerOpinioes.deleteLike(opiniao.likes);
                              opiniao.likes.removeWhere((element) =>
                                  element.idUsuario ==
                                  controllerOpinioes.usuario.id);
                            }

                            await Future.delayed(
                                const Duration(milliseconds: 250));
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
                          likeCount: opiniao.totalDislike >= 0
                              ? opiniao.totalDislike
                              : 0,
                          countBuilder:
                              (int? count, bool isLiked, String text) {
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
                  controllerOpinioes.usuario.id == opiniao.pacienteId
                      ? TextButton.icon(
                          onPressed: () => Get.toNamed(Routes.POSTAR_TRATAMENTO,
                              arguments: opiniao),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black87,
                          ),
                          label: const Text(
                            'Editar',
                            style: TextStyle(color: Colors.black87),
                          ))
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
