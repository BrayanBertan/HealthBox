import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';

class CardPesquisa extends GetView<AcompanhamentosController> {
  const CardPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 1),
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.green),
            ),
            const AutoSizeText('Questionários pendentes'),
            const SizedBox(
              width: 5,
            ),
            Container(
              margin: const EdgeInsets.only(right: 1),
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
            ),
            const AutoSizeText('Questionários pendentes')
          ],
        ),
      ),
    );
  }
}
