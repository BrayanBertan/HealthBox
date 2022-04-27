import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/filtros/dialog_filtros.dart';

import '../../../../../core/values/keys.dart';
import '../../../../../routes/app_pages.dart';

class HeaderFiltro extends GetView<AcompanhamentosController> {
  HeaderFiltro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Acompanhamentos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(Routes.GRAFICOS_OPINIOES)!
                    .then((val) => controller.getUsuariosAcompanhamentos()),
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
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () => Get.toNamed(Routes.POSTAR_TRATAMENTO),
            style: ElevatedButton.styleFrom(primary: Colors.white),
            icon: const Icon(Icons.add),
            label: const Text(
              'Criar novo acompanhamento',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
