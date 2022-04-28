import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/filtros/card_pesquisa.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/filtros/card_usuarios_acompanhamentos.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';

class AcompanhamentoPage extends GetView<AcompanhamentosController> {
  const AcompanhamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acompanhamentos'),
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [CardPesquisa(), CardUsuariosAcompanhamentos()],
        ),
      ),
    );
  }
}
