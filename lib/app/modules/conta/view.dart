import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/widgets/add_vinculo_dialog.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';
import 'package:healthbox/core/theme/app_colors.dart';

import '../../../core/values/keys.dart';

class ContaPage extends StatelessWidget {
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
              child: ListTile(
                onTap: () {
                  Get.toNamed('/conta/usuario');
                },
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text('Editar o meu cadastro'),
              ),
            ),
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
