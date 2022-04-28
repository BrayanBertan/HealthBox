import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/item_list_acompanhamentos.dart';
import 'package:healthbox/app/widgets/shimmer_listagem_simples.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ListAcompanhamentos extends GetView<AcompanhamentosController> {
  const ListAcompanhamentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = ResponsiveWrapper.of(context).screenHeight > 600;
    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      child: Scrollbar(
        child: Obx(
          () => controller.carregando
              ? const ShimmerListagemSimples()
              : controller.usuariosAcompanhamentos.isEmpty
                  ? const Text(
                      'Nenhum acompanhamento encontrado para esse filtro...',
                      textAlign: TextAlign.center,
                    )
                  : ListView.separated(
                      physics: const ScrollPhysics(),
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: controller.acompanhamentos.length,
                      itemBuilder: (context, index) {
                        return ItemListAcompanhamentos(
                          index: index,
                        );
                      }),
        ),
      ),
    );
  }
}
