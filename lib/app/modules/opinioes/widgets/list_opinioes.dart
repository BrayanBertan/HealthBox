import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/item_list_opiniao.dart';
import 'package:healthbox/app/modules/opinioes/widgets/row_paginacao.dart';

class ListOpinioes extends GetView<OpinioesController> {
  const ListOpinioes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: controller.isGerenciarMinhasOpinioesOpen
            ? MediaQuery.of(context).size.width * 0.8
            : MediaQuery.of(context).size.width,
        child: Obx(
          () => controller.carregando
              ? const Text(
                  'carregando...',
                  textAlign: TextAlign.center,
                )
              : controller.opinioes.isEmpty
                  ? const Text(
                      'Nenhuma opinião encontrada para esse filtro...',
                      textAlign: TextAlign.center,
                    )
                  : Scrollbar(
                      child: ListView.builder(
                          shrinkWrap: true,
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
