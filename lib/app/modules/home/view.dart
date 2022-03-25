import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/home/controller.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  final controller_login = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    controller_login.getUsuario();
    return Scaffold(
      appBar: AppBar(),
      drawer: const SideMenu(),
      body: Container(
        child: Obx(() => Text('${controller_login.token}')),
      ),
    );
  }
}
