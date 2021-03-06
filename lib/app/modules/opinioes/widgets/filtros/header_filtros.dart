import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/filtros/dialog_filtros.dart';
import 'package:healthbox/core/theme/app_colors.dart';

import '../../../../../core/values/keys.dart';
import '../../../../../routes/app_pages.dart';

class HeaderFiltro extends StatelessWidget {
  HeaderFiltro({Key? key}) : super(key: key);
  final controller = Get.find<OpinioesController>();
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
              width: 10,
            ),
            Container(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(Routes.GRAFICOS_OPINIOES)!
                    .then((val) => controller.getOpinioes()),
                style: ElevatedButton.styleFrom(primary: Colors.white),
                icon: Image.asset(
                  '${baseImagemUrl}graficos.png',
                  width: 30,
                  fit: BoxFit.cover,
                ),
                label: const Text(
                  'Gráficos',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
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
        controller.usuario.tipo == TipoUsuario.MEDICO
            ? Container()
            : ExpansionTile(
                onExpansionChanged: (val) =>
                    controller.isGerenciarMinhasOpinioesOpen = val,
                title: const Text('Gerenciar minhas opiniões'),
                children: [
                    ListTile(
                      onTap: () => Get.toNamed(Routes.POSTAR_TRATAMENTO)!
                          .then((value) => controller.getOpinioes()),
                      title: const Text('Nova postagem'),
                      trailing: const Icon(Icons.add),
                    ),
                    Obx(
                      () => ListTile(
                        onTap: () {
                          controller.setIsMinhasOpinoesChecked();
                        },
                        title: const Text('Minhas postagens'),
                        trailing: const Icon(Icons.list),
                        tileColor: controller.isMinhasOpinoesChecked
                            ? corPrincipal
                            : Colors.white,
                      ),
                    ),
                  ]),
      ],
    );
  }
}
