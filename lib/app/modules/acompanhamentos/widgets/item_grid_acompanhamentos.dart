import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ItemGridAcompanhamentos extends StatelessWidget {
  const ItemGridAcompanhamentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.QUESTIONARIOS_ACOMPANHAMENTO),
      child: Card(
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              '${baseImagemUrl}teste.jpg',
              fit: BoxFit.fill,
              height:
                  ResponsiveWrapper.of(context).screenHeight > 600 ? 150 : 100,
            ),
            AutoSizeText(
              'Nomeeeee',
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            AutoSizeText(
              '2 questionários pendentes',
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
