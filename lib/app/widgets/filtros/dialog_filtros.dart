import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../../core/values/keys.dart';
import '../../data/models/medicamento.dart';
import '../../modules/opinioes/controller.dart';
import '../../modules/opinioes/widgets/sub_controllers/controller_filtro_opinoes.dart';

class DialogFiltros extends GetView<OpinioesController> {
  FiltroOpinioesController controllerFiltro =
      Get.find<OpinioesController>().filtros.clone();

  DialogFiltros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Filtros',
                style: titulo,
              ),
              Text(
                'Ordenar por',
                style: subTitulo,
              ),
              Obx(() => Container(
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: DropdownButton<String>(
                        underline: Container(),
                        isDense: false,
                        value: controllerFiltro.orderBy,
                        items: controllerFiltro.orderByList
                            .map((Map<String, dynamic> item) =>
                                DropdownMenuItem<String>(
                                    value: item['valor'],
                                    child: Text(
                                      item['titulo'],
                                    )))
                            .toList(),
                        onChanged: controllerFiltro.setOrderBy),
                  )),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Eficácia',
                style: subTitulo,
              ),
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          Radio(
                              value: '&eficaz',
                              groupValue: controllerFiltro.eficaz,
                              onChanged: controllerFiltro.setEficaz),
                          const Text('Todos')
                        ]),
                      ),
                      Expanded(
                          child: Column(children: [
                        Radio(
                            value: '&eficaz=1',
                            groupValue: controllerFiltro.eficaz,
                            onChanged: controllerFiltro.setEficaz),
                        const Text('Eficazes')
                      ])),
                      Expanded(
                        child: Column(children: [
                          Radio(
                              value: '&eficaz=0',
                              groupValue: controllerFiltro.eficaz,
                              onChanged: controllerFiltro.setEficaz),
                          const Text('Ineficazes')
                        ]),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Medicamento',
                style: subTitulo,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: DropdownSearch<Medicamento>(
                  mode: Mode.DIALOG,
                  dropdownBuilder: (_, medicamento) =>
                      Container(child: Text('${controllerFiltro.medicamento}')),
                  dropdownButtonBuilder: (_) => const Icon(Icons.list),
                  dropdownSearchDecoration: const InputDecoration(
                    isDense: true,
                  ),
                  showSearchBox: true,
                  emptyBuilder: (_, __) => const Center(
                    child: Text(
                      'Nenhum medicamento foi encontrado',
                    ),
                  ),
                  searchDelay: const Duration(milliseconds: 1000),
                  isFilteredOnline: true,
                  onFind: (String? filter) =>
                      controller.getMedicamentos(filter),
                  onChanged: controllerFiltro.setMedicamento,
                ),
              ),
              Text('Medicamentos selecionados', style: titulo),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          controllerFiltro.medicamentosSelecionados.length,
                      itemBuilder: (context, index) => Column(
                            children: [
                              ListTile(
                                  title: Text(
                                      '${controllerFiltro.medicamentosSelecionados[index].nome}'),
                                  trailing: IconButton(
                                    onPressed: controllerFiltro
                                                .medicamentosSelecionados[index]
                                                .id ==
                                            0
                                        ? null
                                        : () => controllerFiltro
                                            .deleteMedicamento(index),
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: controllerFiltro
                                                  .medicamentosSelecionados[
                                                      index]
                                                  .id ==
                                              0
                                          ? Colors.grey
                                          : Colors.red,
                                    ),
                                  )),
                            ],
                          )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: Get.back,
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: corPrincipal,
                      ),
                      label: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: controllerFiltro.setController,
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      icon: Image.asset(
                        '${baseImagemUrl}filtro.png',
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                      label: const Text(
                        'Filtrar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
