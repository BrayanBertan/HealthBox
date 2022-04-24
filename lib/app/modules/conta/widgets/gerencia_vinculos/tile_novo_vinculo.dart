import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/add_vinculo_dialog.dart';

class TileNovoVinculo extends GetView<ContaController> {
  const TileNovoVinculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(context: context, builder: (_) => const DialogAddVinculo())
            .then((val) {
          controller.setPesquisaNome(null);
          controller.vinculosDisponiveis.clear();
        });
      },
      leading: const Icon(Icons.person_add),
      title: const Text('Novo vínculo'),
    );
  }
}
