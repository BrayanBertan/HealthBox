import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/widgets/filtros/barra_filtro.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';

class OpinioesPage extends GetView<OpinioesController> {
  OpinioesPage({Key? key}) : super(key: key);
  final controller_login = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    controller_login.getUsuario();
    return Scaffold(
      appBar: AppBar(),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            BarraFiltro(),
          ],
        ),
      ),
    );
  }
}
