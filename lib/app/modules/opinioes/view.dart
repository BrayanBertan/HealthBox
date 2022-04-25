import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/filtros/card_opinioes.dart';
import 'package:healthbox/app/modules/opinioes/widgets/filtros/card_pesquisa.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';

class OpinioesPage extends GetView<OpinioesController> {
  OpinioesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Opiniões')),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [CardPesquisa(), CardOpinioes()],
        ),
      ),
    );
  }
}
