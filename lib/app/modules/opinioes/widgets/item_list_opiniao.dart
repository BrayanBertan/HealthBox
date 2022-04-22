import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/info_item_list_opiniao.dart';
import 'package:healthbox/app/modules/opinioes/widgets/interacoes_item_list_opiniao.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:shimmer/shimmer.dart';

class ItemListOpiniao extends GetView<OpinioesController> {
  int index;
  ItemListOpiniao({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 1,
          margin: const EdgeInsets.only(left: 25.0),
          padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
          child: Card(
            margin: const EdgeInsets.only(bottom: 25),
            child: Stack(
              children: [
                InfoItemListOpiniao(index: index),
                InteracoesItemListOpiniao(index: index)
              ],
            ),
          ),
        ),
        Positioned(
            left: -2,
            child: Row(
              children: [
                controller.opinioes[index].paciente?.fotoPath == null
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
                        imageUrl:
                            controller.opinioes[index].paciente!.fotoPath!,
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
                const SizedBox(
                  width: 2,
                ),
                Text(
                    '${controller.opinioes[index].paciente?.nome ?? ''} ${controller.opinioes[index].dataPostagem}')
              ],
            )),
      ],
    );
  }
}
