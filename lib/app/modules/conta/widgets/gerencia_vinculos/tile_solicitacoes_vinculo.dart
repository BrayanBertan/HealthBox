import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/item_list_vinculos.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/shimmer_vinculos.dart';

class TileSolicitacoesVinculo extends GetView<ContaController> {
  const TileSolicitacoesVinculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.notifications_on),
      title: const Text('Solicitações de vínculo'),
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: Obx(
            () => controller.carregandoVinculos
                ? const ShimmerVinculos()
                : controller.solicitacoesVinculo.isEmpty
                    ? const Center(child: Text('Sem solicitações pendentes'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.solicitacoesVinculo.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ItemListaVinculos(
                                lista: controller.solicitacoesVinculo,
                                index: index,
                                trailing: <IconButton>[
                                  IconButton(
                                    icon: const Icon(
                                      Icons.person_add_alt_1,
                                      color: Colors.green,
                                    ),
                                    onPressed: () =>
                                        controller.salvarVinculo(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.person_remove_alt_1,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => controller.deletaVinculo(
                                        controller.vinculosAtivos[index].id!,
                                        controller.vinculosAtivos[index].nome),
                                  )
                                ],
                              ),
                              const Divider()
                            ],
                          );
                        },
                      ),
          ),
        )
      ],
    );
  }
}
