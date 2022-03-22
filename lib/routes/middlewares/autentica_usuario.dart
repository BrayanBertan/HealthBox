import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/app/modules/login/controller.dart';

class AutenticaUsuario extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('3 AutenticaUsuario');
    final controller = Get.find<LoginController>();
    if (controller.verificaSessao()) {
      controller.getSessaoToken();
      return null;
    } else {
      return const RouteSettings(name: '/login');
    }
  }

  @override
  GetPageBuilder onPageBuildStart(GetPageBuilder? page) {
    print('4 AutenticaUsuario');
    UsuarioProvider.token = Get.find<LoginController>().token;
    return page!;
  }
}
