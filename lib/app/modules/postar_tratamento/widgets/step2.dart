import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/periodicidade_medicamento.dart';
import 'package:healthbox/app/data/enums/unidade_medida.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/dialog_info_medicamento.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class Step2TratamentoPage extends GetView<PostarTratamentoController> {
  Step2TratamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          initialValue: controller.descricao,
          onChanged: controller.setDescricao,
          maxLines: 10,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.text_fields,
            ),
            border: OutlineInputBorder(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: "Descrição do tratamento",
            enabledBorder: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownSearch<Medicamento>(
          mode: Mode.DIALOG,
          dropdownSearchDecoration: const InputDecoration(
            labelText: 'Medicamentos',
            isDense: true,
          ),
          showSearchBox: true,
          emptyBuilder: (_, __) => const Center(
            child: Text(
              'Nenhum medicamento foi encontrado.Use o campo de pesquisa acima.',
              textAlign: TextAlign.center,
            ),
          ),
          showClearButton: true,
          searchDelay: const Duration(milliseconds: 1000),
          isFilteredOnline: true,
          onFind: (String? filter) => controller.getMedicamentos(filter),
          onChanged: (Medicamento? medicamento) =>
              controller.medicamentosSelecionadosInfo.add(MedicamentoInfo(
                  dose: '',
                  unidadeMedida: UnidadeMedida.MG,
                  duracao: '',
                  intervalo: '',
                  periodicidadeMedicamento: PeriodicidadeMedicamento.horas,
                  medicamento: medicamento!)),
        ),
        Text('Medicamentos selecionados', style: titulo),
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Obx(
            () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.medicamentosSelecionadosInfo.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        ListTile(
                          title: Text(
                              '${controller.medicamentosSelecionadosInfo[index].medicamento}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => DialogInfoMedicamento(
                                          medicamento: controller
                                                  .medicamentosSelecionadosInfo[
                                              index]));
                                },
                                icon: const Icon(
                                  Icons.info,
                                  color: Colors.yellow,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.medicamentosSelecionadosInfo
                                      .remove(controller
                                          .medicamentosSelecionadosInfo[index]);
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.medicamentosSelecionadosInfo[index].dose
                                    .isEmpty
                                ? 'informações de uso são obrigátorias, clique no icone amarelo'
                                : '',
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    )),
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
