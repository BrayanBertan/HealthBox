import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:shimmer/shimmer.dart';

class CardPesquisa extends GetView<AcompanhamentosController> {
  const CardPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        child: Column(
          children: [
            if (controller.usuarioSelecionado?.fotoPath == null)
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
                imageUrl: controller.usuarioSelecionado!.fotoPath,
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
            const SizedBox(
              height: 5,
            ),
            Text(
              '${controller.usuarioSelecionado.nome}',
              style: subTitulo,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(right: 1),
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
              ),
              title: const AutoSizeText('Acompanhamentos pendentes'),
            ),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(right: 1),
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
              ),
              title: const AutoSizeText('Sem acompanhamentos pendentes'),
            ),
          ],
        ),
      ),
    );
  }
}
