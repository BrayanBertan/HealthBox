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
              alignment: WrapAlignment.center,
              children: [
                Obx(() => CustomTextRich(
                    titulo: 'Nome: ', descricao: controller.nome)),
                Obx(() => CustomTextRich(
                    titulo: 'Telefone: ', descricao: controller.telefone)),
                Obx(() => CustomTextRich(
                    titulo: 'Data de nascimento: ',
                    descricao: controller.formataDataNascimento)),
              ],
            )),
          ],
        ),
        StepLines(texto: '2'),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Obx(() =>
                CustomTextRich(titulo: 'Email: ', descricao: controller.email)),
            Obx(() => CustomTextRich(
                titulo: 'Genero: ', descricao: controller.generoName)),
            Obx(() => CustomTextRich(
                titulo: 'Você é: ', descricao: controller.tipoName)),
          ],
        ),
        StepLines(texto: '3'),
        controller.tipo == TipoUsuario.PACIENTE
            ? Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Obx(() => CustomTextRich(
                      titulo: 'CPF: ', descricao: controller.cpf)),
                  Obx(() => CustomTextRich(
                      titulo: 'Altura: ', descricao: controller.altura)),
                  Obx(() => CustomTextRich(
                      titulo: 'Peso: ', descricao: controller.peso)),
                ],
              )
            : Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Obx(() => CustomTextRich(
                      titulo: 'CRM: ', descricao: controller.crm)),
                  Obx(() => CustomTextRich(
                      titulo: 'Especialização: ',
                      descricao: controller.especializacaoName)),
                  Obx(() => CustomTextRich(
                      titulo: 'Descrição: ', descricao: controller.descricao)),
                ],
              ),
      ],
    );
  }
}
