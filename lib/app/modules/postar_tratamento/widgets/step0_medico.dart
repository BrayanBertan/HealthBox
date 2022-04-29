import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/shimmer_select.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/tile_dropdown_vinculo.dart';
import 'package:healthbox/app/widgets/ficha_paciente/ficha.dart';

class Step0MedicoTratamentoPage extends GetView<PostarTratamentoController> {
  const Step0MedicoTratamentoPage({Key? key}) : super(key: key);

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
        Obx(() => FichaPaciente(paciente: controller.vinculo?.paciente)),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
