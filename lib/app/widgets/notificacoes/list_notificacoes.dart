import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/app/widgets/notificacoes/item_list_notificacoes.dart';

class ListNotificacoes extends GetView<LoginController> {
  const ListNotificacoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.notificacoes.isEmpty
          ? const AutoSizeText(
              'sem notificações',
              textAlign: TextAlign.center,
            )
          : ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  ),
              itemCount: controller.notificacoes.length,
              itemBuilder: (_, index) => ItemListNotificacoes(
                    notificacao: controller.notificacoes[index],
                  )),
    );
  }
}
