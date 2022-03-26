import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class ContaPage extends StatelessWidget {
  const ContaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal100,
      drawer: SideMenu(),
      appBar: AppBar(title: const Text('Configurações')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Dados',
              style: TextStyle(color: corPrincipal),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Get.toNamed('/conta/usuario');
                },
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text('Editar o meu cadastro'),
              ),
            ),
            Text(
              'Vinculos',
              style: TextStyle(color: corPrincipal),
            ),
            Card(
                child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.person_add),
                  title: const Text('Novo vinculo'),
                ),
                const Divider(),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.people),
                  title: const Text('Gerenciar vinculos'),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
