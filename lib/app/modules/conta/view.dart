import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/button_deletar_conta.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_crm/tile_gerenciar_crm.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/tile_gerenciar_vinculos.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/tile_novo_vinculo.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/tile_solicitacoes_vinculo.dart';
import 'package:healthbox/app/modules/conta/widgets/tile_editar_cadastro.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class ContaPage extends GetView<ContaController> {
  const ContaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal100,
      drawer: SideMenu(),
      appBar: AppBar(title: const Text('Configurações')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Dados',
              style: TextStyle(color: corPrincipal),
            ),
            Card(
                child: Column(
              children: [
                TileEditarCadastro(),
                const Divider(),
                controller.usuario is Medico ? TileGerenciarCrm() : Container(),
              ],
            )),
            Text(
              'vínculo',
              style: TextStyle(color: corPrincipal),
            ),
            Card(
                child: Column(
              children: [
                TileNovoVinculo(),
                const Divider(),
                TileGerenciarVinculos(),
                const Divider(),
                TileSolicitacoesVinculo()
              ],
            )),
            ButtonDeletarConta()
          ],
        ),
      ),
    );
  }
}
