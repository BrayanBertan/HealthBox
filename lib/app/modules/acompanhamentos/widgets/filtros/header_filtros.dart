import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';

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
            controller.usuario.tipo == TipoUsuario.MEDICO
                ? Container(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () => Get.toNamed(Routes.GRAFICOS_OPINIOES)!
                          .then(
                              (val) => controller.getUsuariosAcompanhamentos()),
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
                  )
                : Container(),
            controller.usuario.tipo == TipoUsuario.MEDICO
                ? IconButton(
                    onPressed: () => controller.orderByUsuario(),
                    icon: Obx(() => Icon(controller.orderByUsuarioVar == 1
                        ? Icons.arrow_downward
                        : Icons.arrow_upward)))
                : Container()
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Obx(
          () => controller.usuario.tipo == TipoUsuario.MEDICO
              ? Container(
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
                )
              : Container(),
        )
      ],
    );
  }
}
