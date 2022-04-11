import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
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
          initialValue: controller.titulo,
          onChanged: controller.setTitulo,
          maxLines: 10,
          decoration: InputDecoration(
              icon: const Icon(
                Icons.text_fields,
              ),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              labelText: "Descrição do tratamento",
              enabledBorder: const OutlineInputBorder(),
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              errorText: controller.tituloErroMensagem),
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
              'Nenhum medicamento foi encontrado',
            ),
          ),
          showClearButton: true,
          searchDelay: const Duration(milliseconds: 1000),
          isFilteredOnline: true,
          onFind: (String? filter) => controller.getMedicamentos(filter),
          onChanged: (Medicamento? medicamento) =>
              controller.medicamentosSelecionados.add(medicamento!),
        ),
        Text('Medicamentos selecionados', style: titulo),
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Obx(
            () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.medicamentosSelecionados.length,
                itemBuilder: (context, index) => ListTile(
                      title:
                          Text('${controller.medicamentosSelecionados[index]}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => DialogInfoMedicamento(
                                      medicamento: controller
                                          .medicamentosSelecionados[index]));
                            },
                            icon: const Icon(
                              Icons.info,
                              color: Colors.yellow,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.medicamentosSelecionados.remove(
                                  controller.medicamentosSelecionados[index]);
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
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
