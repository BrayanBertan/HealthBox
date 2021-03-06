import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/item_list_opiniao.dart';
import 'package:healthbox/app/modules/opinioes/widgets/row_paginacao.dart';
import 'package:healthbox/app/modules/opinioes/widgets/shimmer_opinioes.dart';

class ListOpinioes extends GetView<OpinioesController> {
  const ListOpinioes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: controller.isGerenciarMinhasOpinioesOpen
            ? MediaQuery.of(context).size.height * 0.8
            : MediaQuery.of(context).size.height,
        child: Obx(
          () => controller.carregando
              ? const ShimmerOpinioes()
              : controller.opinioes.isEmpty
                  ? const Text(
                      'Nenhuma opinião encontrada para esse filtro...',
                      textAlign: TextAlign.center,
                    )
                  : Scrollbar(
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: controller.opinioes.length + 1,
                          itemBuilder: (context, index) {
                            return index == controller.opinioes.length
                                ? RowPaginacao()
                                : ItemListOpiniao(
                                    index: index,
                                  );
                          }),
                    ),
        ),
      ),
    );
  }
}
