import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';

class Step2Page extends StatelessWidget {
  Step2Page({Key? key}) : super(key: key);
  final controller = Get.find<DadosUsuarioController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
              icon: const Icon(
                Icons.email,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Email",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
        ),
        TextFormField(
          onChanged: (value) {},
          obscureText: true,
          decoration: InputDecoration(
              icon: const Icon(
                Icons.password,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Senha",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
        ),
        Row(
          children: [
            const Text('Gênero', style: TextStyle(fontSize: 15)),
            const SizedBox(
              width: 15,
            ),
            DropdownButton<Genero>(
                value: Genero.MASCULINO,
                items: Genero.values
                    .map((Genero tipo) => DropdownMenuItem<Genero>(
                        value: tipo, child: Text(tipo.name)))
                    .toList(),
                onChanged: (Genero? tipo) {})
          ],
        ),
        const Text(
          'Você é?',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => GestureDetector(
                  onTap: () => controller.setTipo(TipoUsuario.PACIENTE),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: controller.tipo == TipoUsuario.PACIENTE
                                ? corPrincipal
                                : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Image.asset(
                          '${baseImagemUrl}patient.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                      const Text(
                        'Paciente',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                )),
            Obx(() => GestureDetector(
                  onTap: () => controller.setTipo(TipoUsuario.MEDICO),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: controller.tipo == TipoUsuario.MEDICO
                                ? corPrincipal
                                : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Image.asset(
                          '${baseImagemUrl}doctor.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                      const Text(
                        'Médico',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                )),
          ],
        )
      ],
    );
  }
}
