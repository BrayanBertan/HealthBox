import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/quill_editor.dart';

import '../../opinioes/controller.dart';

class Step1TratamentoPage extends StatelessWidget {
  Step1TratamentoPage({Key? key}) : super(key: key);
  final controller_opinioes = Get.find<OpinioesController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          decoration: InputDecoration(
            icon: const Icon(
              Icons.title,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100)),
            labelText: "Titulo",
            enabledBorder: InputBorder.none,
            labelStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        QuillEditorColumn(),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
