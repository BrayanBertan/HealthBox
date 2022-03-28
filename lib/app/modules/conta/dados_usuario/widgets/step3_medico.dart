import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/especializacao.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../controller.dart';

class Step3MedicoPage extends StatelessWidget {
  Step3MedicoPage({Key? key}) : super(key: key);
  final controller = Get.find<DadosUsuarioController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => controller.especializacoes.length > 0
            ? MultiSelectChipField<Especializacao?>(
                initialValue: controller.especializacoesSelecionadas,
                title: const Text('Especializações'),
                searchable: true,
                height: 50,
                searchHint: 'pesquisar',
                onTap: (itens) {
                  if (itens.length > 2) {
                    itens.removeLast();
                  }
                  controller.especializacoesSelecionadas
                      .assignAll(itens as List<Especializacao>);
                },
                items: controller.especializacoes
                    .map((especializacao) => MultiSelectItem<Especializacao>(
                        especializacao, especializacao.nome))
                    .toList(),
              )
            : const Text('Carregando...')),
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
