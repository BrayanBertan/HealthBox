import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';
import 'package:healthbox/routes/app_pages.dart';

class TileEditarCadastro extends StatelessWidget {
  const TileEditarCadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.delete<DadosUsuarioController>();
        Get.toNamed(Routes.DADOS_USUARIO);
      },
      leading: const Icon(Icons.list_alt_outlined),
      title: const Text('Editar o meu cadastro'),
    );
  }
}
