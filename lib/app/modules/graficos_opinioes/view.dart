import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:healthbox/routes/app_pages.dart';

import 'controller.dart';

class GraficosOpinioesPage extends GetView<GraficosOpinioesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos de opiniões'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Text(
                'Seleciona o tipo de gráfico',
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
                      onTap: () => Get.toNamed(Routes.GRAFICO_BARRA),
                      child: Column(
                        children: [
                          Image.asset(
                              '${baseImagemUrl}${controller.tiposDeGraficos[index]['imagem']}'),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(controller.tiposDeGraficos[index]['titulo'])
                        ],
                      ),
                    );
                  }),
            ],
          )),
    );
  }
}
