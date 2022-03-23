import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_theme.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Já tem uma conta? ",
          style: textoInfo,
        ),
        TextButton(
            onPressed: () => Get.offNamed('/login'),
            child: Text(
              'Entrar',
              style: TextStyle(
                  fontSize: 14,
                  color: corPrincipal,
                  fontWeight: FontWeight.w700),
            ))
      ],
    );
  }
}
