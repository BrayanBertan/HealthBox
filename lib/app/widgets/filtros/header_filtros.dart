import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/widgets/filtros/dialog_filtros.dart';

import '../../../core/values/keys.dart';
import '../../../routes/app_pages.dart';

class HeaderFiltro extends StatelessWidget {
  const HeaderFiltro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Opiniões',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(context: context, builder: (_) => DialogFiltros());
                },
                style: ElevatedButton.styleFrom(primary: Colors.white),
                icon: Image.asset(
                  '${baseImagemUrl}filtro.png',
                  width: 20,
                  fit: BoxFit.cover,
                ),
                label: const Text(
                  'Filtros',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ExpansionTile(
            title: const Text('Gerenciar minhas opiniões'),
            children: [
              ListTile(
                title: const Text('Nova postagem'),
                trailing: const Icon(Icons.add),
                onTap: () => Get.toNamed(Routes.POSTAR_OPINIAO),
              ),
              ListTile(
                title: const Text('Minhas postagens'),
                trailing: const Icon(Icons.list),
              ),
            ]),
      ],
    );
  }
}
