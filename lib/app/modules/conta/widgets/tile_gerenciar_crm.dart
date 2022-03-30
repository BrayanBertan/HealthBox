import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';

class TileGerenciarCrm extends StatelessWidget {
  TileGerenciarCrm({Key? key}) : super(key: key);
  final controller = Get.find<ContaController>();
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.document_scanner),
      title: const Text('Gerenciar crm'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.search,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                    labelText: "Novo crm",
                    enabledBorder: InputBorder.none,
                    labelStyle: const TextStyle(color: Colors.grey)),
              )),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                color: Colors.green,
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Obx(
            () => controller.crms.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.crms.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpansionTile(
                        title: Text(
                          '${controller.crms[index].crm} ${controller.crms[index].estado_sigla}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        children: controller.crms[index].especializacoes!
                            .map((especializacao) => ListTile(
                                  leading: Text(
                                    '${controller.crms[index].crm} ${controller.crms[index].estado_sigla}',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  title: Text(especializacao.nome),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete_forever),
                                    color: Colors.redAccent,
                                  ),
                                ))
                            .toList(),
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
