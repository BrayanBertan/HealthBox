import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/unidade_medida.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/controller_info_medicamento.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../../data/enums/periodicidade_medicamento.dart';

class DialogInfoMedicamento extends GetView<ControllerInfoMedicamento> {
  MedicamentoInfo medicamento;
  DialogInfoMedicamento({required this.medicamento, Key? key})
      : super(key: key) {
    controller.id = medicamento.id;
    controller.setDose(medicamento.dose.isEmpty ? null : medicamento.dose);
    controller.setIntervalo(
        medicamento.intervalo.isEmpty ? null : medicamento.intervalo);
    controller
        .setDuracao(medicamento.duracao.isEmpty ? null : medicamento.duracao);
    controller.periodicidade = medicamento.periodicidadeMedicamento;
    controller.unidade = medicamento.unidadeMedida;
    controller.medicamento = medicamento.medicamento;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.medicamento.nome,
              style: subTitulo,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Dose ',
                  style: TextStyle(
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Container(
                  width: 55,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Obx(
                    () => TextFormField(
                      initialValue: '${controller.dose ?? ''}',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        isDense: false,
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(color: Colors.grey),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: controller.setDose,
                    ),
                  ),
                ),
                Container(
                  width: 65,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Obx(
                    () => DropdownButton<UnidadeMedida>(
                        isDense: false,
                        value: controller.unidade,
                        items: UnidadeMedida.values
                            .map((UnidadeMedida unidadeMedida) =>
                                DropdownMenuItem<UnidadeMedida>(
                                  value: unidadeMedida,
                                  child: Text(unidadeMedida.name),
                                ))
                            .toList(),
                        onChanged: (UnidadeMedida? val) =>
                            controller.unidade = val),
                  ),
                ),
                Text(
                  'a cada ',
                  style: TextStyle(
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Container(
                  width: 55,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Obx(
                    () => TextFormField(
                      initialValue: '${controller.intervalo ?? ''}',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        isDense: false,
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(color: Colors.grey),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: controller.setIntervalo,
                    ),
                  ),
                ),
                Container(
                  width: 75,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Obx(
                    () => DropdownButton<PeriodicidadeMedicamento>(
                        isDense: false,
                        value: controller.periodicidade,
                        items: PeriodicidadeMedicamento.values
                            .map((PeriodicidadeMedicamento unidadeMedida) =>
                                DropdownMenuItem<PeriodicidadeMedicamento>(
                                  value: unidadeMedida,
                                  child: Text(unidadeMedida.name),
                                ))
                            .toList(),
                        onChanged: (PeriodicidadeMedicamento? val) =>
                            controller.periodicidade = val),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'por ',
                  style: TextStyle(
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Container(
                  width: 55,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Obx(
                    () => TextFormField(
                      initialValue: '${controller.duracao ?? ''}',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        isDense: false,
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(color: Colors.grey),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: controller.setDuracao,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'dias ',
                  style: TextStyle(
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              child: Obx(
                () => ElevatedButton.icon(
                  onPressed: !controller.formValido()
                      ? null
                      : () => controller.salvarInfo(),
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  label: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Obx(() => Text(
                  controller.mensagemErro ?? '',
                  style: const TextStyle(color: Colors.red),
                )),
          ],
        ),
      ),
    );
  }
}
