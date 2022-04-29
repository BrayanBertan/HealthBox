import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/quill_editor.dart';

class Step1TratamentoPage extends GetView<PostarTratamentoController> {
  const Step1TratamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          initialValue: controller.titulo,
          focusNode: controller.tituloFocus,
          onChanged: controller.setTitulo,
          decoration: InputDecoration(
              icon: const Icon(
                Icons.title,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Título",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              errorText: controller.tituloErroMensagem),
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
        ),
        Obx(() => Align(
            alignment: Alignment.centerRight,
            child: Text('${controller.titulo?.length ?? 0}/50'))),
        const SizedBox(
          height: 10,
        ),
        QuillEditorColumn(),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.textoErroMensagem ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
                Text(
                  '${(controller.editorLength) - 2}/200',
                  style: TextStyle(
                      color: controller.editorLength <= 200
                          ? Colors.black
                          : Colors.red),
                )
              ],
            )),
        Obx(() => controller.isPaciente
            ? Row(
                children: [
                  const Text('Você considera esse tratamento'),
                  Expanded(
                      child: Column(children: [
                    Radio(
                        value: 1,
                        groupValue: controller.eficacia,
                        onChanged: controller.setEficacia),
                    const Text('Eficaz')
                  ])),
                  Expanded(
                    child: Column(children: [
                      Radio(
                          value: 0,
                          groupValue: controller.eficacia,
                          onChanged: controller.setEficacia),
                      const Text('Ineficaz')
                    ]),
                  ),
                ],
              )
            : Container()),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
