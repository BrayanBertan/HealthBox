import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/routes/app_pages.dart';

class ItemListAcompanhamentos extends GetView<AcompanhamentosController> {
  int index;
  ItemListAcompanhamentos({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.DETALHES_TRATAMENTO,
          arguments: controller.acompanhamentos[index]),
      child: ListTile(
        leading: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.acompanhamentos[index].respostaPendente!
                  ? Colors.green
                  : Colors.blue),
        ),
        title: AutoSizeText(
          controller.acompanhamentos[index].tratamento?.titulo ?? '',
          maxLines: 1,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => controller.usuario.tipo == TipoUsuario.MEDICO
                  ? TextButton.icon(
                      onPressed: () => Get.toNamed(Routes.POSTAR_TRATAMENTO,
                          arguments: controller.acompanhamentos[index]),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black87,
                      ),
                      label: const Text(
                        'Editar',
                        style: TextStyle(color: Colors.black87),
                      ))
                  : controller.acompanhamentos[index].respostaPendente!
                      ? TextButton.icon(
                          onPressed: () => Get.toNamed(
                                  Routes.QUESTIONARIO_ACOMPANHAMENTOS,
                                  arguments: {
                                    'questionario': controller
                                        .acompanhamentos[index].questionario,
                                    'tipo': 1
                                  }),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black87,
                          ),
                          label: const Text(
                            'Responder',
                            style: TextStyle(color: Colors.black87),
                          ))
                      : Container(),
            ),
            IconButton(
              onPressed: () {
                controller.getQuestionarios(
                    idAcompanhamento: controller.acompanhamentos[index].id);
                Get.toNamed(Routes.QUESTIONARIO_ACOMPANHAMENTOS, arguments: {
                  'questionario':
                      controller.acompanhamentos[index].questionario,
                  'tipo': 2
                });
              },
              icon: const Icon(Icons.list),
            ),
          ],
        ),
      ),
    );
  }
}
