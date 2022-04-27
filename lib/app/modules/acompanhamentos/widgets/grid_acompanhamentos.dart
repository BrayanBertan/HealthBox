import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/item_grid_acompanhamentos.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/shimmer_usuarios_acompanhamentos.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GridAcompanhamentos extends GetView<AcompanhamentosController> {
  const GridAcompanhamentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = ResponsiveWrapper.of(context).screenHeight > 600;
    return Obx(
      () => controller.carregando
          ? ShimmerUsuariosAcompanhamentos(tamanho: screenHeight)
          : controller.usuariosAcompanhamentos.isEmpty
              ? Text(
                  'Nenhum ${controller.usuario.tipo == TipoUsuario.PACIENTE ? 'médico' : 'paciente'} encontrado para esse filtro...',
                  textAlign: TextAlign.center,
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: screenHeight ? 200 : 150,
                      mainAxisExtent: screenHeight ? 200 : 150,
                      crossAxisSpacing: screenHeight ? 10 : 5,
                      mainAxisSpacing: screenHeight ? 10 : 5,
                      childAspectRatio: 1),
                  itemCount: controller.usuariosAcompanhamentos.length,
                  itemBuilder: (context, index) {
                    return ItemGridAcompanhamentos(
                      index: index,
                    );
                  }),
    );
  }
}
