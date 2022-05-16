import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/filtros/card_acompanhamentos.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/filtros/card_pesquisa.dart';
import 'package:healthbox/app/widgets/notificacoes/custom_appbar.dart';

class ListagemAcompanhamentoPage extends GetView<AcompanhamentosController> {
  const ListagemAcompanhamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: 'Acompanhamentos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [CardPesquisa(), CardAcompanhamentos()],
        ),
      ),
    );
  }
}
