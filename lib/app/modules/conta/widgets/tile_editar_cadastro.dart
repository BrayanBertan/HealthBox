import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TileEditarCadastro extends StatelessWidget {
  const TileEditarCadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.toNamed('/conta/usuario');
      },
      leading: const Icon(Icons.list_alt_outlined),
      title: const Text('Editar o meu cadastro'),
    );
  }
}
