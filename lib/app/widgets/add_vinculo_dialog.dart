import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/item_list_vinculos.dart';
import 'package:healthbox/app/modules/conta/widgets/gerencia_vinculos/shimmer_vinculos.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class DialogAddVinculo extends GetView<ContaController> {
  const DialogAddVinculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Novo vinculo',
              style: titulo,
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  initialValue: controller.pesquisaNome,
                  onChanged: controller.setPesquisaNome,
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.search,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      labelText: "Digite o nome",
                      enabledBorder: InputBorder.none,
                      labelStyle: const TextStyle(color: Colors.grey),
                      errorText: controller.pesquisaNomeErroMensagem),
                )),
                Obx(
                  () => ElevatedButton(
                      onPressed: controller.pesquisaNomeValido()
                          ? () => controller.getUsuariosDisponiveis()
                          : null,
                      child: const Text('Buscar')),
                )
              ],
            ),
            Obx(
              () => controller.carregandoVinculos
                  ? const ShimmerVinculos()
                  : controller.vinculosDisponiveis.isEmpty
                      ? Center(
                          child: Text(
                              'Nenhum resultado para essa pesquisa ${controller.pesquisaNome ?? ''}'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.vinculosDisponiveis.length,
                          itemBuilder: (_, index) => ItemListaVinculos(
                                lista: controller.vinculosDisponiveis,
                                index: index,
                                trailing: <IconButton>[
                                  IconButton(
                                    icon: const Icon(Icons.person_add),
                                    onPressed: () =>
                                        controller.salvarVinculo(index),
                                  ),
                                ],
                              )),
            ),
          ],
        ),
      ),
    );
  }
}
