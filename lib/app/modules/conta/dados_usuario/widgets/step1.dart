import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/image_options.dart';
import 'package:healthbox/core/values/keys.dart';

class Step1Page extends StatelessWidget {
  Step1Page({Key? key}) : super(key: key);
  final controller = Get.find<DadosUsuarioController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) =>
                  ImageOptionsSheet(controller.onImageSelected)),
          child: Obx(() => Column(
                children: [
                  CircleAvatar(
                      child: controller.foto == null
                          ? Image.asset('${baseImagemUrl}user_pic.png')
                          : Image.file(File(controller.foto)),
                      minRadius: 75,
                      maxRadius: 100),
                  const Text(
                    'Escolha a sua foto de perfil',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              )),
        ),
        Obx(() => TextFormField(
              initialValue: controller.nome,
              onChanged: controller.setNome,
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.person,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  labelText: "Nome",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey),
                  errorText: controller.nomeErroMensagem),
            )),
        Obx(() => TextFormField(
              initialValue: controller.telefone,
              onChanged: controller.setTelefone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.phone,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  labelText: "Telefone",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey),
                  errorText: controller.telefoneErroMensagem),
            )),
        Obx(() => Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    controller.dataNascimento = await showDatePicker(
                      context: context,
                      locale: const Locale("pt"),
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 36500)),
                      lastDate: DateTime.now(),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        '${baseImagemUrl}calendario.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(controller.formataDataNascimento)
                    ],
                  ),
                ),
                const Text(
                  'Selecione a sua data de nascimento',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )
              ],
            )),
      ],
    );
  }
}