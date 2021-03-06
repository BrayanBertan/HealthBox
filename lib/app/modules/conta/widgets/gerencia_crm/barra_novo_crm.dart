import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';

import '../../../../../core/values/keys.dart';

class BarraNovoCrm extends GetView<ContaController> {
  String titulo;

  String uf;
  IconData icone;

  BarraNovoCrm(
      {this.titulo = 'Novo CRM',
      this.uf = 'SC',
      this.icone = Icons.add,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 4,
              child: Obx(() => TextFormField(
                    controller: controller.crmController,
                    onChanged: (value) => controller.crm = value,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.document_scanner,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: titulo,
                        enabledBorder: InputBorder.none,
                        labelStyle: const TextStyle(color: Colors.grey),
                        errorText: controller.crmErroMensagem),
                  ))),
          Expanded(
              flex: 1,
              child: Obx(() => DropdownButton<String>(
                  menuMaxHeight: 250,
                  value: controller.crmuf,
                  underline: Container(),
                  items: ufs
                      .map((String uf) =>
                          DropdownMenuItem<String>(value: uf, child: Text(uf)))
                      .toList(),
                  onChanged: (uf) {
                    controller.crmuf = uf;
                  }))),
          Obx(() => IconButton(
                onPressed: controller.isLoading
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        controller.salvarCrm();
                      },
                icon: Icon(icone),
                color: Colors.green,
              ))
        ],
      ),
    );
  }
}
