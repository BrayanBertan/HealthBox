import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/crm.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_crm/barra_novo_crm.dart';

import '../../../../../core/theme/app_text_theme.dart';
import '../../../../data/models/especializacao.dart';

class DialogDetalhesCrm extends StatelessWidget {
  Crm crm;
  DialogDetalhesCrm({required this.crm, Key? key}) : super(key: key);
  final controller = Get.find<ContaController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'CRM ${crm.crm} ${crm.estado_sigla}',
              style: titulo,
            ),
            BarraNovoCrm(
              titulo: 'Editar crm',
              crm: crm.crm,
              uf: crm.estado_sigla,
              icone: Icons.save,
            ),
            Text(
              'Especializações',
              style: subTitulo,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: crm.especializacoes != null
                  ? crm.especializacoes!
                      .map((especializacao) => ListTile(
                            title: Text(especializacao.nome),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete_forever),
                              color: Colors.redAccent,
                            ),
                          ))
                      .toList()
                  : [const Text('Sem especializações')],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  GetX<ContaController>(
                      init: controller.getEspecializacoes(),
                      builder: (controller) => Container(
                            child: DropdownButton<Especializacao>(
                                value: controller.especializacoes[0],
                                items: controller.especializacoes
                                    .map((Especializacao especializacao) =>
                                        DropdownMenuItem<Especializacao>(
                                            value: especializacao,
                                            child: Text(especializacao.nome)))
                                    .toList(),
                                onChanged: (especializacao) {}),
                          )),
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}