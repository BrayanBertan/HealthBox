import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';

class AutenticaUsuario extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final controller = Get.find<LoginController>();
    return controller.verificaSessao('brayanbertan@gmail.com')
        ? null
        : const RouteSettings(name: '/login');
  }
}
