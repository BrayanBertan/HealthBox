import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_questao.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/controller_questoes.dart';

class DialogQuestoes extends GetView<ControllerQuestoes> {
  Questao questao;
  DialogQuestoes({required this.questao, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => TextFormField(
                    initialValue: controller.descricaoQuestao,
                    onChanged: controller.setDescricaoQuestao,
                    maxLines: 3,
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.text_fields,
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: "Descrição da questão",
                        enabledBorder: const OutlineInputBorder(),
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        errorText: controller.descricaoQuestaoErroMensagem),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(150),
                    ],
                  ),
                ),
                Obx(() => Row(
                      children: [
                        const Text('O tipo dessa questão é'),
                        Expanded(
                            child: Column(children: [
                          Radio(
                              value: TipoQuestao.D,
                              groupValue: controller.tipo,
                              onChanged: controller.setTipo),
                          const Text('Descritiva')
                        ])),
                        Expanded(
                          child: Column(children: [
                            Radio(
                                value: TipoQuestao.O,
                                groupValue: controller.tipo,
                                onChanged: controller.setTipo),
                            const Text('Objetiva')
                          ]),
                        ),
                      ],
                    )),
                Obx(() => controller.tipo == TipoQuestao.O
                    ? Column(
                        children: [
                          const Text(
                            'Opções de resposta',
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Expanded(
                                  child: TextFormField(
                                    controller:
                                        controller.descricaoOpcaController,
                                    onChanged: controller.setDescricaoOpcao,
                                    decoration: InputDecoration(
                                        labelText: "Nova opção",
                                        labelStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        errorText: controller
                                            .descricaoOpcaoErroMensagem),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(150),
                                    ],
                                  ),
                                ),
                              ),
                              Obx(
                                () => IconButton(
                                    onPressed:
                                        controller.opcoesQuestao.length >= 5
                                            ? null
                                            : () {
                                                controller.addOpcao();
                                              },
                                    icon: Icon(
                                      Icons.add,
                                      color:
                                          controller.opcoesQuestao.length >= 5
                                              ? Colors.grey
                                              : Colors.green,
                                    )),
                              ),
                            ],
                          ),
                          controller.opcoesQuestao.isEmpty
                              ? Text(controller.opcoesQuestaoErroMensagem ==
                                      null
                                  ? 'Sem opções cadastradas para essa questão'
                                  : '')
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.opcoesQuestao.length,
                                      itemBuilder: (_, index) => ListTile(
                                            title: Text(controller
                                                .opcoesQuestao[index]
                                                .descricao),
                                            trailing: IconButton(
                                                onPressed: () => controller
                                                    .opcoesQuestao
                                                    .removeAt(index),
                                                icon: const Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red,
                                                )),
                                          )),
                                ),
                          Obx(() => Text(
                                controller.opcoesQuestaoErroMensagem ?? '',
                                style: const TextStyle(color: Colors.red),
                              )),
                        ],
                      )
                    : Container()),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 50,
                    child: Obx(
                      () => ElevatedButton.icon(
                        onPressed: controller.formValido()
                            ? controller.salvarInfo
                            : null,
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
                    )),
              ],
            )));
  }
}
