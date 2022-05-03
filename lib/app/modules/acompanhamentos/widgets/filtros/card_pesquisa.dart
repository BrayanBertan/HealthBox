import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';

class CardPesquisa extends GetView<AcompanhamentosController> {
  const CardPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pesquise pelos seus pacientes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 50,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Pesquisar pacientes",
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {},
                    child: Icon(
                      Icons.search,
                      color: corPrincipal,
                    ))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(
                    child: AutoSizeText(
                      'Visualizar por ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => Container(
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: controller.tipoVisualizacao == 1
                                  ? const Offset(3, 5)
                                  : const Offset(0, 1),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () => controller.changeVisualizacao(1),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          icon: Image.asset(
                            '${baseImagemUrl}gridview.png',
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                          label: const Text(
                            'Vínculo',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Obx(
                      () => Container(
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: controller.tipoVisualizacao == 2
                                  ? const Offset(3, 5)
                                  : const Offset(0, 1),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () => controller.changeVisualizacao(2),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          icon: Image.asset(
                            '${baseImagemUrl}table_calendar.png',
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                          label: const Text(
                            'Data',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
