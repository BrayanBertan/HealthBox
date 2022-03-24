import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/especializacao.dart';
import 'package:healthbox/core/values/keys.dart';

import '../controller.dart';

class Step3MedicoPage extends StatelessWidget {
  Step3MedicoPage({Key? key}) : super(key: key);
  final controller = Get.find<DadosUsuarioController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Especialização', style: TextStyle(fontSize: 15)),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Obx(() => DropdownButton<Especializacao>(
                    value: controller.especializacao,
                    menuMaxHeight: 250,
                    items: especializacoes
                        .map((Especializacao especializacao) =>
                            DropdownMenuItem<Especializacao>(
                                value: especializacao,
                                child: Text(especializacao.titulo)))
                        .toList(),
                    onChanged: controller.setEspecializacao)))
          ],
        ),
        Obx(() => TextFormField(
              controller: controller.descricaoController,
              onChanged: controller.setDescricao,
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.list_alt_outlined,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  labelText: "Descrição",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey),
                  errorText: controller.descricaoErroMensagem),
              maxLines: 5,
            )),
      ],
    );
  }
}
