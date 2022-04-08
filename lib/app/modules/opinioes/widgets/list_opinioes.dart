import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/row_paginacao.dart';
import 'package:healthbox/app/modules/opinioes/widgets/item_list_opiniao.dart';

class ListOpinioes extends StatelessWidget {
  ListOpinioes({Key? key}) : super(key: key);
  final controller = Get.find<OpinioesController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      child: Obx(
        () => controller.carregando
            ? const Text(
                'carregando...',
                textAlign: TextAlign.center,
              )
            : ListView.builder(
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
    );
  }
}
