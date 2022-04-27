import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        Obx(
          () => TextFormField(
            initialValue: controller.descricao,
            onChanged: controller.setDescricao,
            maxLines: 5,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.text_fields,
              ),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              labelText: controller.isPaciente
                  ? "Descrição do tratamento"
                  : "Descrição do paciente",
              enabledBorder: OutlineInputBorder(),
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(150),
            ],
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
            () => controller.medicamentosSelecionadosInfo.isEmpty
                ? const Text(
                    'Nenhum medicamento selecionado',
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
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
                                                  .medicamentosSelecionadosInfo[
                                              index]);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              controller.medicamentosSelecionadosInfo[index]
                                      .dose.isEmpty
                                  ? 'informações de uso são obrigátorias, clique no ícone amarelo'
                                  : '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        )),
          ),
        ),
      ],
    );
  }
}
