import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/quill_editor.dart';

class Step1TratamentoPage extends StatelessWidget {
  Step1TratamentoPage({Key? key}) : super(key: key);
  final controller = Get.find<PostarTratamentoController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        QuillEditorColumn(),
        const SizedBox(
          height: 25,
        ),
        ElevatedButton(
            onPressed: () => controller.salvarOpiniao(),
            child: const Text('salvar'))
      ],
    );
  }
}
