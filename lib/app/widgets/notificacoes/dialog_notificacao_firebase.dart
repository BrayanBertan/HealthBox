import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/app/widgets/notificacoes/list_notificacoes.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class DialogNotificacaoFirebase extends GetView<LoginController> {
  DialogNotificacaoFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Notificações não lidas',
              style: subTitulo,
              textAlign: TextAlign.center,
            ),
            ListNotificacoes()
          ],
        ),
      ),
    );
  }
}
