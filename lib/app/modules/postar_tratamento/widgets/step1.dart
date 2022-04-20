import 'package:flutter/material.dart';
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
        ),
        const SizedBox(
          height: 10,
        ),
        QuillEditorColumn(),
        const SizedBox(
          height: 25,
        ),
        const SizedBox(
          height: 25,
        ),
        Obx(() => Wrap(
              spacing: MediaQuery.of(context).size.width * 0.25,
              children: [
                DropdownButton<int>(
                    isDense: true,
                    underline: Container(),
                    value: controller.eficacia,
                    items: controller.eficazList
                        .map((Map<String, dynamic> eficacia) =>
                            DropdownMenuItem<int>(
                                value: eficacia['valor'],
                                child: Text(
                                  eficacia['titulo'],
                                )))
                        .toList(),
                    onChanged: controller.setEficacia),
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
      ],
    );
  }
}
