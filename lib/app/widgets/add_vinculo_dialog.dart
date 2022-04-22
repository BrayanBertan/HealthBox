import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/shimmer_vinculos.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/values/keys.dart';

class DialogAddVinculo extends GetView<ContaController> {
  const DialogAddVinculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Novo vinculo',
              style: titulo,
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  initialValue: controller.pesquisaNome,
                  onChanged: controller.setPesquisaNome,
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.search,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      labelText: "Digite o nome",
                      enabledBorder: InputBorder.none,
                      labelStyle: const TextStyle(color: Colors.grey),
                      errorText: controller.pesquisaNomeErroMensagem),
                )),
                Obx(
                  () => ElevatedButton(
                      onPressed: controller.pesquisaNomeValido()
                          ? () => controller.getUsuariosDisponiveis()
                          : null,
                      child: const Text('Buscar')),
                )
              ],
            ),
            controller.carregandoVinculosDisponiveis
                ? const ShimmerVinculos()
                : controller.vinculosDisponiveis.isEmpty
                    ? Center(
                        child: Obx(
                        () => Text(
                            'Nenhum resultado para essa pesquisa ${controller.pesquisaNome ?? ''}'),
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.vinculosDisponiveis.length,
                        itemBuilder: (_, index) => ListTile(
                              leading: controller.vinculosDisponiveis[index]
                                          .fotoPath ==
                                      null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              '${baseImagemUrl}user_pic.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: controller
                                          .vinculosDisponiveis[index].fotoPath!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                              child: const CircleAvatar(
                                                maxRadius: 20,
                                                minRadius: 20,
                                              ),
                                              baseColor: corPrincipal50,
                                              highlightColor: corPrincipal),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                              title: Text(
                                  controller.vinculosDisponiveis[index].nome),
                              trailing: ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.person_add)),
                            ))
          ],
        ),
      ),
    );
  }
}
