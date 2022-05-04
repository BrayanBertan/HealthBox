import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../controller.dart';

class Step3PacientePage extends GetView<DadosUsuarioController> {
  const Step3PacientePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Expanded(
                  child: TextFormField(
                    initialValue: controller.altura,
                    onChanged: controller.setAltura,
                    focusNode: controller.alturaFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        controller.pesoFocus.requestFocus(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      AlturaInputFormatter(),
                    ],
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.height,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: "Altura",
                        enabledBorder: InputBorder.none,
                        labelStyle: const TextStyle(color: Colors.grey),
                        errorText: controller.alturaErroMensagem),
                  ),
                )),
            Obx(() => Expanded(
                  child: TextFormField(
                    initialValue: controller.peso,
                    onChanged: controller.setPeso,
                    focusNode: controller.pesoFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        controller.saudeComorbidadesFocus.requestFocus(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      PesoInputFormatter(),
                    ],
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.balance,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: "Peso",
                        enabledBorder: InputBorder.none,
                        labelStyle: const TextStyle(color: Colors.grey),
                        errorText: controller.pesoErroMensagem),
                  ),
                )),
          ],
        ),
        const Text(
          'Conte-nos mais sobre o seu histórico de saúde',
          style: subTitulo,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          initialValue: controller.comorbidades,
          onChanged: controller.setComorbidades,
          focusNode: controller.saudeComorbidadesFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => controller.saudeAlergiasFocus.requestFocus(),
          maxLines: 4,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.text_fields,
            ),
            border: OutlineInputBorder(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: "Comorbidades",
            enabledBorder: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(150),
          ],
        ),
        Obx(() => Align(
            alignment: Alignment.centerRight,
            child: Text('${controller.comorbidades.length}/150'))),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          initialValue: controller.alergiasMedicamentosas,
          onChanged: controller.setAlergiasMedicamentosas,
          focusNode: controller.saudeAlergiasFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) =>
              controller.saudePreDisposicoesFocus.requestFocus(),
          maxLines: 4,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.text_fields,
            ),
            border: OutlineInputBorder(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: "Alergia à medicamentos",
            enabledBorder: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(150),
          ],
        ),
        Obx(() => Align(
            alignment: Alignment.centerRight,
            child: Text('${controller.alergiasMedicamentosas.length}/150'))),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          initialValue: controller.predisposicaoGenetica,
          onChanged: controller.setPredisposicaoGenetica,
          focusNode: controller.saudePreDisposicoesFocus,
          textInputAction: TextInputAction.done,
          maxLines: 4,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.text_fields,
            ),
            border: OutlineInputBorder(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: "Predisposição genética",
            enabledBorder: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(150),
          ],
        ),
        Obx(() => Align(
            alignment: Alignment.centerRight,
            child: Text('${controller.predisposicaoGenetica.length}/150'))),
      ],
    );
  }
}
