import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shimmer/shimmer.dart';

class ItemGridUsuariosAcompanhamentos
    extends GetView<AcompanhamentosController> {
  int index;
  ItemGridUsuariosAcompanhamentos({required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.getAcompanhamentos(index);
        Get.toNamed(Routes.LISTAGEM_ACOMPANHAMENTOS);
      },
      child: Card(
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            controller.usuariosAcompanhamentos[index].fotoPath == null
                ? Image.asset(
                    '${baseImagemUrl}user_pic.png',
                    fit: BoxFit.fill,
                    height: ResponsiveWrapper.of(context).screenHeight > 600
                        ? 150
                        : 100,
                  )
                : CachedNetworkImage(
                    imageUrl:
                        controller.usuariosAcompanhamentos[index].fotoPath!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: ResponsiveWrapper.of(context).screenHeight > 600
                          ? 150
                          : 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                        child: Image.asset(
                          '${baseImagemUrl}user_pic.png',
                          fit: BoxFit.fill,
                          height:
                              ResponsiveWrapper.of(context).screenHeight > 600
                                  ? 150
                                  : 100,
                        ),
                        baseColor: corPrincipal50,
                        highlightColor: corPrincipal),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),

            AutoSizeText(
              controller.usuariosAcompanhamentos[index].nome,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            // AutoSizeText(
            //   '2 questionários pendentes',
            //   textAlign: TextAlign.center,
            //   maxLines: 1,
            // ),
          ],
        ),
      ),
    );
  }
}
