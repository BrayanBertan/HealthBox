import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/widgets/add_vinculo_dialog.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';
import 'package:healthbox/core/theme/app_colors.dart';

import '../../../core/values/keys.dart';

class ContaPage extends GetView<ContaController> {
  const ContaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal100,
      drawer: SideMenu(),
      appBar: AppBar(title: const Text('Configurações')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
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
                ListTile(
                  onTap: () {
                    Get.toNamed('/conta/usuario');
                  },
                  leading: const Icon(Icons.list_alt_outlined),
                  title: const Text('Editar o meu cadastro'),
                ),
                const Divider(),
                controller.usuario is Medico
                    ? ExpansionTile(
                        leading: const Icon(Icons.document_scanner),
                        title: const Text('Gerenciar crm'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
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
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100)),
                                      labelText: "Novo crm",
                                      enabledBorder: InputBorder.none,
                                      labelStyle:
                                          const TextStyle(color: Colors.grey)),
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ExpansionTile(
                                          title: Text(
                                            '${controller.crms[index].crm} ${controller.crms[index].estado_sigla}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          children: controller
                                              .crms[index].especializacoes!
                                              .map((especializacao) => ListTile(
                                                    leading: Text(
                                                      '${controller.crms[index].crm} ${controller.crms[index].estado_sigla}',
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    title: Text(
                                                        especializacao.nome),
                                                    trailing: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                          Icons.delete_forever),
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
                      )
                    : Container(),
              ],
            )),
            Text(
              'Vinculos',
              style: TextStyle(color: corPrincipal),
            ),
            Card(
                child: Column(
              children: [
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context, builder: (_) => DialogAddVinculo());
                  },
                  leading: const Icon(Icons.person_add),
                  title: const Text('Novo vinculo'),
                ),
                const Divider(),
                ExpansionTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Gerenciar vinculos'),
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 15,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                    child: Image.asset(
                                        '${baseImagemUrl}user_pic.png'),
                                    minRadius: 50,
                                    maxRadius: 50),
                                title: Text('Luis Vidal Miranda'),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_forever),
                                  color: Colors.redAccent,
                                ),
                              ),
                              const Divider()
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
                const Divider(),
                ExpansionTile(
                  leading: const Icon(Icons.notifications_on),
                  title: const Text('Solicitações de vinculo'),
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 15,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                    child: Image.asset(
                                        '${baseImagemUrl}user_pic.png'),
                                    minRadius: 50,
                                    maxRadius: 50),
                                title: Text('Luis Vidal Miranda'),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.person_add),
                                  color: Colors.green,
                                ),
                              ),
                              const Divider()
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
