import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/shimmer_select.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/tile_dropdown_vinculo.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';

class Step4MedicoTratamentoPage extends GetView<PostarTratamentoController> {
  const Step4MedicoTratamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.carregandoVinculos
              ? const ShimmerSelects()
              : controller.vinculos.isEmpty
                  ? const Text('Sem vínculos disponiveis')
                  : DropdownSearch<Vinculo>(
                      mode: Mode.DIALOG,
                      dropdownSearchDecoration: const InputDecoration(
                        labelText: 'Selecionar o paciente',
                        isDense: true,
                      ),
                      onPopupDismissed: controller.setIsVinculoUntouched,
                      dropDownButton: Container(),
                      items: controller.vinculos,
                      dropdownButtonBuilder: null,
                      dropdownBuilder: (_, vinculo) => controller.vinculo ==
                              null
                          ? const Text('')
                          : TileDropDownVinculo(vinculo: controller.vinculo),
                      popupItemBuilder: (_, vinculo, __) =>
                          TileDropDownVinculo(vinculo: vinculo),
                      showSearchBox: true,
                      emptyBuilder: (_, __) => const Center(
                        child: Text(
                          'Nenhum vínculo foi encontrado.Use o campo de pesquisa acima.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      showClearButton: true,
                      onChanged: (Vinculo? vinculo) =>
                          controller.vinculo = vinculo,
                    ),
        ),
        Obx(() => Text(
              controller.vinculoErroMensagem ?? '',
              style: const TextStyle(color: Colors.red),
            )),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            controller.dataInicial = await showDatePicker(
              context: context,
              locale: const Locale("pt"),
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(
                2500,
                1,
                1,
              ),
            );
          },
          child: Row(
            children: [
              Image.asset(
                '${baseImagemUrl}calendario.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              Obx(() => Text('Data inicial ${controller.formataDataInicial}'))
            ],
          ),
        ),
        Obx(() => Text(
              controller.dataInicialErroMensagem ?? '',
              style: const TextStyle(color: Colors.red),
            )),
        const SizedBox(
          height: 15,
        ),
        Wrap(
          children: [
            const Text(
              ' Repetir o questionário por  ',
              style: TextStyle(fontSize: 15),
            ),
            Obx(() => Container(
                  width: 55,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: (controller.diasDuracao != null &&
                                  !controller.diasQuestionarioValida())
                              ? Colors.red
                              : Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    initialValue: '${controller.diasDuracao ?? ''}',
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      isDense: false,
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    onChanged: controller.setDiasDuracao,
                  ),
                )),
            const Text(
              ' dias, uma vez a cada  ',
              style: TextStyle(fontSize: 15),
            ),
            Obx(() => Container(
                  width: 55,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: (controller.quantidadePeriodicidade != null &&
                                  !controller.periodicidadeQuestionarioValida())
                              ? Colors.red
                              : Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    initialValue: '${controller.quantidadePeriodicidade ?? ''}',
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      isDense: false,
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    onChanged: controller.setQuantidadePeriodicidade,
                  ),
                )),
            const Text(
              ' dias',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        Obx(() => Text(
              controller.duracaoQuestionarioErroMensagem ?? '',
              style: const TextStyle(color: Colors.red),
            )),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Lembre-se depois de criado o acompanhamento só poderá ser editado antes da data de inicio!',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: corPrincipal),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
