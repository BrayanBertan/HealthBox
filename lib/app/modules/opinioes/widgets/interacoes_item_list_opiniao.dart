import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/routes/app_pages.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/values/keys.dart';

class InteracoesItemListOpiniao extends StatelessWidget {
  const InteracoesItemListOpiniao({Key? key}) : super(key: key);

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
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Image.asset('${baseImagemUrl}gostar.png', width: 25),
                        const SizedBox(
                          width: 2,
                        ),
                        Text('10'),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Image.asset('${baseImagemUrl}dislike.png',
                                width: 25)
                          ],
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text('5')
                      ],
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.DETALHES_OPINIAO),
                child: Row(
                  children: [
                    Image.asset('${baseImagemUrl}details.png', width: 25),
                    const SizedBox(
                      width: 2,
                    ),
                    Text('Detalhes')
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
