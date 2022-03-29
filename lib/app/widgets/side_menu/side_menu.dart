import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/core/theme/app_colors.dart';

import '../../../core/values/keys.dart';
import '../../modules/login/controller.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    dynamic usuario;
    usuario = loginController.getLogin();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: corPrincipal,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        child: Image.asset('${baseImagemUrl}user_pic.png'),
                        minRadius: 40,
                        maxRadius: 40),
                    TextButton(
                        onPressed: Get.find<LoginController>().logout,
                        child: const Text(
                          'sair',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Olá, ${usuario.nome}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed('/conta');
                        },
                        child: const Text(
                          'Minha conta.',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Get.toNamed('/');
            },
            leading:
                Image.asset('${baseImagemUrl}acompanhamentos.png', width: 40),
            title: const Text('Acompanhamentos'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Get.toNamed('/');
            },
            leading: Image.asset('${baseImagemUrl}feedback.png', width: 40),
            title: const Text('Opiniões'),
          ),
        ],
      ),
    );
  }
}
