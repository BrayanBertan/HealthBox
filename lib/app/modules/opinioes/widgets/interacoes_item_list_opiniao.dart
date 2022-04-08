import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:like_button/like_button.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/values/keys.dart';

class InteracoesItemListOpiniao extends StatelessWidget {
  int index;
  InteracoesItemListOpiniao({required this.index, Key? key}) : super(key: key);
  final controller = Get.find<OpinioesController>();
  @override
  Widget build(BuildContext context) {
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
                  LikeButton(
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
                    likeCount: 50,
                    countBuilder: (int? count, bool isLiked, String text) {
                      var color = isLiked ? Colors.green : Colors.black87;
                      return Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  LikeButton(
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
                    likeCount: 50,
                    countBuilder: (int? count, bool isLiked, String text) {
                      var color = isLiked ? Colors.red : Colors.black87;
                      return Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    },
                  ),
                ],
              ),
              false
                  ? TextButton.icon(
                      onPressed: () {},
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
                onTap: () =>
                    Get.toNamed(Routes.DETALHES_OPINIAO, arguments: index)!
                        .then((value) => FocusScope.of(context).unfocus()),
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
