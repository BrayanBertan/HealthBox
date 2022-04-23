import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/item_list_vinculos.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/shimmer_vinculos.dart';

class TileGerenciarVinculos extends GetView<ContaController> {
  const TileGerenciarVinculos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.people),
      title: const Text('Gerenciar vínculos'),
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: Obx(() => controller.carregandoVinculos
              ? const ShimmerVinculos()
              : controller.vinculosAtivos.isEmpty
                  ? const Center(child: const Text('Sem vínculos ativos'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.vinculosAtivos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ItemListaVinculos(
                              lista: controller.vinculosAtivos,
                              index: index,
                              trailing: <IconButton>[
                                IconButton(
                                  icon: const Icon(
                                    Icons.person_remove_alt_1,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => controller.deletaVinculo(
                                      controller.vinculosAtivos[index].id!,
                                      controller.vinculosAtivos[index].nome),
                                ),
                              ],
                            ),
                            const Divider()
                          ],
                        );
                      },
                    )),
        )
      ],
    );
  }
}
