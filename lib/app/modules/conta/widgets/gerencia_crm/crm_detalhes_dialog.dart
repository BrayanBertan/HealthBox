import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_crm/barra_novo_crm.dart';

import '../../../../../core/theme/app_text_theme.dart';
import '../../../../data/models/especializacao.dart';

class DialogDetalhesCrm extends StatelessWidget {
  final controller = Get.find<ContaController>();
  DialogDetalhesCrm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Text(
                  'CRM ${controller.crmDescricao}',
                  style: titulo,
                )),
            Obx(() => BarraNovoCrm(
                  titulo: 'Editar CRM',
                  uf: controller.crmuf,
                  icone: Icons.save,
                )),
            Text(
              'Especializações',
              style: subTitulo,
            ),
            Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: controller.especializacoesCrm.isNotEmpty
                    ? controller.especializacoesCrm
                        .map((especializacao) => ListTile(
                              title: Text(especializacao.nome),
                              trailing: IconButton(
                                onPressed: () {
                                  controller.deletarEspecializacao(
                                      especializacao.id!, especializacao.nome);
                                },
                                icon: const Icon(Icons.delete_forever),
                                color: Colors.redAccent,
                              ),
                            ))
                        .toList()
                    : [const Text('Sem especializações')],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  GetX<ContaController>(
                      init: controller.getEspecializacoes(),
                      builder: (controller) => Container(
                            child: controller.especializacoes.isNotEmpty
                                ? DropdownButton<Especializacao>(
                                    value: controller.especializacaoSelecionada,
                                    items: controller.especializacoes
                                        .map((Especializacao especializacao) =>
                                            DropdownMenuItem<Especializacao>(
                                                value: especializacao,
                                                child:
                                                    Text(especializacao.nome)))
                                        .toList(),
                                    onChanged: (especializacao) {
                                      controller.especializacaoSelecionada =
                                          especializacao;
                                    })
                                : const Text('carregando...'),
                          )),
                  Expanded(
                    child: IconButton(
                      onPressed: controller.salvarEspecializacao,
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
