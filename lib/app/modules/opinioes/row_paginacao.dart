import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';

class RowPaginacao extends StatelessWidget {
  RowPaginacao({Key? key}) : super(key: key);
  final controller = Get.find<OpinioesController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: 50,
            child: Obx(
              () => ElevatedButton(
                  onPressed: controller.page == 1
                      ? null
                      : () => controller.setPageAnterior(),
                  child: const Text('Anterior')),
            )),
        Container(
            height: 50,
            child: Obx(
              () => ElevatedButton(
                  onPressed: controller.opinioes.length < 10
                      ? null
                      : () => controller.setPageProxima(),
                  child: const Text('Próximo')),
            )),
      ],
    );
  }
}
