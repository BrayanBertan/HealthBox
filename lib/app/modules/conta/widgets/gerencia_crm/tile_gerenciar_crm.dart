import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_crm/barra_novo_crm.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_crm/crm_detalhes_dialog.dart';

class TileGerenciarCrm extends StatelessWidget {
  TileGerenciarCrm({Key? key}) : super(key: key);
  final controller = Get.find<ContaController>();
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.document_scanner),
      title: const Text('Gerenciar crm'),
      children: [
        BarraNovoCrm(),
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => controller.crms.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.crms.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          '${controller.crms[index].crm} ${controller.crms[index].estado_sigla}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) => DialogDetalhesCrm(
                                        crm: controller.crms[index],
                                      )),
                              icon: const Icon(Icons.edit),
                              color: Colors.yellow,
                            ),
                            IconButton(
                              onPressed: () => controller.deletarCrm(
                                  controller.crms[index].id!,
                                  '${controller.crms[index].crm} ${controller.crms[index].estado_sigla}'),
                              icon: const Icon(Icons.delete_forever),
                              color: Colors.redAccent,
                            )
                          ],
                        ),
                      );
                    },
                  )
                : const Text('Você não possui nenhum crm'),
          ),
        )
      ],
    );
  }
}
