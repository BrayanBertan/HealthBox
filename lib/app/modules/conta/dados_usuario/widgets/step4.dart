import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/custom_text_rich.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/steps_line.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../../../../core/values/keys.dart';
import '../controller.dart';

class Step4Page extends StatelessWidget {
  Step4Page({Key? key}) : super(key: key);
  final controller = Get.find<DadosUsuarioController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Confirmar dados',
          style: titulo,
        ),
        StepLines(texto: '1'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => CircleAvatar(
                child: controller.foto == null
                    ? Image.asset('${baseImagemUrl}user_pic.png')
                    : Image.file(File(controller.foto)),
                minRadius: 25,
                maxRadius: 25)),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                Obx(() => Text('Nome: ${controller.nome} ')),
                Obx(() => Text('Telefone: ${controller.telefone} ')),
                Obx(() => Text(
                    'Data de nascimento: ${controller.formataDataNascimento()}  ')),
              ],
            )),
          ],
        ),
        StepLines(texto: '2'),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            Obx(() => CustomTextRich(
                titulo: 'Email: ', descricao: controller.nome ?? '')),
            Obx(() => CustomTextRich(
                titulo: 'Genero: ', descricao: controller.generoName ?? '')),
            Obx(() => CustomTextRich(
                titulo: 'Você é: ', descricao: controller.tipoName ?? '')),
          ],
        ),
        StepLines(texto: '3'),
        controller.tipo == TipoUsuario.PACIENTE
            ? Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Obx(() => Text('CPF: ${controller.cpf}  ')),
                  Obx(() => Text('Altura: ${controller.altura} ')),
                  Obx(() => Text('Peso: ${controller.peso}  ')),
                ],
              )
            : Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Obx(() => Text('CRM: ${controller.crm}  ')),
                  Obx(() =>
                      Text('Especialização: ${controller.especializacao} ')),
                  Obx(() => Text('Descrição: ${controller.descricao}  ')),
                ],
              ),
      ],
    );
  }
}
