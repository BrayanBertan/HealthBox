import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller.dart';

class Step3PacientePage extends GetView<DadosUsuarioController> {
  const Step3PacientePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => TextFormField(
              initialValue: controller.altura,
              onChanged: controller.setAltura,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                AlturaInputFormatter(),
              ],
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.height,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  labelText: "Altura",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey),
                  errorText: controller.alturaErroMensagem),
            )),
        Obx(() => TextFormField(
              initialValue: controller.peso,
              onChanged: controller.setPeso,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                PesoInputFormatter(),
              ],
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.balance,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  labelText: "Peso",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey),
                  errorText: controller.pesoErroMensagem),
            )),
      ],
    );
  }
}
