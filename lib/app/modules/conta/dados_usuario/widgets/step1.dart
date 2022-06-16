import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/image_options.dart';
import 'package:healthbox/core/values/keys.dart';

class Step1Page extends GetView<DadosUsuarioController> {
  const Step1Page({Key? key}) : super(key: key);

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
                      backgroundImage: controller.foto == null
                          ? const AssetImage('${baseImagemUrl}user_pic.png')
                          : controller.foto is File
                              ? FileImage(controller.foto)
                              : NetworkImage(controller.foto) as ImageProvider,
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
              controller: controller.nomeController,
              focusNode: controller.nomeFocus,
              onChanged: controller.setNome,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => controller.telefoneFocus.requestFocus(),
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
              controller: controller.telefoneController,
              onChanged: controller.setTelefone,
              focusNode: controller.telefoneFocus,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) => controller.getCalendario(context),
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
                  onTap: () => controller.getCalendario(context),
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
