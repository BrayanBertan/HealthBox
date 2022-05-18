import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/graficos/widgets/aviso.dart';
import 'package:healthbox/app/widgets/notificacoes/custom_appbar.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:healthbox/routes/app_pages.dart';

import 'controller.dart';

class GraficosOpinioesPage extends GetView<GraficosOpinioesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Gráficos de opiniões'),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              const Text(
                'Selecione o tipo de gráfico',
                style: titulo,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisExtent: 250,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 25,
                      childAspectRatio: 1),
                  itemCount: controller.tiposDeGraficos.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.endpoint =
                            controller.tiposDeGraficos[index]['endpoint'];
                        controller.usuario.tipo == TipoUsuario.PACIENTE
                            ? controller.getGraficos()
                            : controller.tiposDeGraficos[index]['page'] ==
                                    Routes.GRAFICO_RESPOSTA
                                ? controller.getGraficosResposta()
                                : controller.getGraficosMedico();
                        controller.tituloAppBar =
                            controller.tiposDeGraficos[index]['titulo'];
                        Get.toNamed(controller.tiposDeGraficos[index]['page']);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                              '$baseImagemUrl${controller.tiposDeGraficos[index]['imagem']}'),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            controller.tiposDeGraficos[index]['titulo'],
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }),
              controller.usuario.tipo == TipoUsuario.PACIENTE
                  ? const Aviso()
                  : Container()
            ],
          )),
    );
  }
}
