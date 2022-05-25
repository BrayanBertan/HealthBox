import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/app/widgets/notificacoes/dialog_notificacao_firebase.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class CustomAppBar extends GetView<LoginController>
    implements PreferredSizeWidget {
  String title;
  CustomAppBar({required this.title, Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => InkWell(
              onTap: () => showDialog(
                      context: context,
                      builder: (context) => DialogNotificacaoFirebase())
                  .then((value) => controller.notificacoes.clear()),
              child: Badge(
                badgeContent: Text('${controller.notificacoes.length}',
                    style: const TextStyle(color: Colors.white)),
                child: const Icon(
                  Icons.notifications,
                ),
                badgeColor: corPrincipal,
                animationType: BadgeAnimationType.fade,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}
