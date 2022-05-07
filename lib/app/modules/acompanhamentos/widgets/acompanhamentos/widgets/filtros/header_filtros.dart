import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';

class HeaderFiltro extends StatelessWidget {
  HeaderFiltro({Key? key}) : super(key: key);
  final controller = Get.find<AcompanhamentosController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Acompanhamentos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () => controller.orderByPendente(),
                icon: Obx(() => Icon(controller.orderByPendenteVar == 1
                    ? Icons.arrow_upward
                    : Icons.arrow_downward)))
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
