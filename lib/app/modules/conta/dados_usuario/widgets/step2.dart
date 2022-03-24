import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';

class Step2Page extends StatelessWidget {
  Step2Page({Key? key}) : super(key: key);
  final controller = Get.find<DadosUsuarioController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => TextFormField(
              initialValue: controller.email,
              onChanged: controller.setEmail,
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.email,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  labelText: "Email",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey),
                  errorText: controller.emailErroMensagem),
            )),
        Obx(() => TextFormField(
              initialValue: controller.senha,
              onChanged: controller.setSenha,
              obscureText: true,
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.password,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  labelText: "Senha",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey),
                  errorText: controller.senhaErroMensagem),
            )),
        Obx(() => TextFormField(
              initialValue: controller.senhaRepeticao,
              onChanged: controller.setSenhaRepeticao,
              obscureText: true,
              decoration: InputDecoration(
                  icon: const Icon(
                    Icons.password,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  labelText: "Repita a senha",
                  enabledBorder: InputBorder.none,
                  labelStyle: const TextStyle(color: Colors.grey),
                  errorText: controller.senhaRepeticaoErroMensagem),
            )),
        Row(
          children: [
            const Text('Gênero', style: TextStyle(fontSize: 15)),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Obx(() => DropdownButton<Genero>(
                    value: controller.genero,
                    items: Genero.values
                        .map((Genero tipo) => DropdownMenuItem<Genero>(
                            value: tipo, child: Text(tipo.name)))
                        .toList(),
                    onChanged: controller.setGenero)))
          ],
        ),
      ],
    );
  }
}
