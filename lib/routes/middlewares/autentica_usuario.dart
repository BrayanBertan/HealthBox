import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/routes/app_pages.dart';

import '../../app/data/providers/usuario.dart';

class AutenticaUsuario extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final controller = Get.find<LoginController>();
    if (controller.verificaSessao()) {
      controller.getSessaoToken();
      if (controller.getLogin().tipo == TipoUsuario.MEDICO) {
        return const RouteSettings(name: Routes.ACOMPANHAMENTOS);
      }
      return null;
    } else {
      return const RouteSettings(name: Routes.LOGIN);
    }
  }

  @override
  GetPageBuilder onPageBuildStart(GetPageBuilder? page) {
    UsuarioProvider.token = Get.find<LoginController>().token;
    Get.find<LoginController>().getUsuario();
    return page!;
  }
}
