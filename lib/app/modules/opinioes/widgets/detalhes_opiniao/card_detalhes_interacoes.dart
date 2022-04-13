import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/like.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/modules/opinioes/widgets/controller_interacoes.dart';
import 'package:like_button/like_button.dart';

import '../../../../../routes/app_pages.dart';
import '../../controller.dart';

class CardDetalhesInteracoes extends GetWidget<InteracaoController> {
  Opiniao opiniao;
  final controller_teste = Get.find<OpinioesController>();
  CardDetalhesInteracoes({required this.opiniao, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLiked =
        controller_teste.inicializaLikes(opiniao.likes ?? List<Like>.empty());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      child: Align(
        alignment: Alignment.center,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: controller_teste.isMinhasOpinoesChecked ? 250 : 150,
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
                              controller_teste.setLike(true, opiniao.id!);
                              opiniao.totalLike++;
                            } else {
                              controller_teste.deleteLike(opiniao.likes ?? []);
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
                              controller_teste.setLike(false, opiniao.id!);
                              opiniao.totalDislike++;
                            } else {
                              controller_teste.deleteLike(opiniao.likes ?? []);
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
                  controller_teste.isMinhasOpinoesChecked
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
