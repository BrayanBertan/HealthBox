import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';

class Step4MedicoTratamentoPage extends GetView<PostarTratamentoController> {
  const Step4MedicoTratamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: controller.checkDataInicial(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              controller.dataInicial = await showDatePicker(
                context: context,
                locale: const Locale("pt"),
                initialDate: controller.getDataInicialDisponivel(),
                firstDate: controller.getDataInicialDisponivel(),
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
          Wrap(
            children: [
              const Text(
                'O questionário irá durar ',
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      initialValue: '${controller.diasDuracao ?? ''}',
                      onChanged: controller.setDiasDuracao,
                      focusNode: controller.duracaoFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          controller.intervaloFocus.requestFocus(),
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
                        LengthLimitingTextInputFormatter(2),
                      ],
                    ),
                  )),
              const Text(
                ' dias',
                style: TextStyle(fontSize: 15),
              ),
              const Text(
                ' e se repetirá a cada ',
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      initialValue:
                          '${controller.quantidadePeriodicidade ?? ''}',
                      onChanged: controller.setQuantidadePeriodicidade,
                      focusNode: controller.intervaloFocus,
                      textInputAction: TextInputAction.done,
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
                        LengthLimitingTextInputFormatter(2),
                      ],
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
          Text(
            'Lembre-se depois de criado alguns dados do acompanhamento só poderam ser editados até a data de inicio!',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: corPrincipal),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
