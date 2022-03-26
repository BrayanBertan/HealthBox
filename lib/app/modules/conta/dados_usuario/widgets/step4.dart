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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Confirmar dados',
          style: titulo,
        ),
        const SizedBox(
          height: 15,
        ),
        Obx(() => CircleAvatar(
            child: controller.foto == null
                ? Image.asset('${baseImagemUrl}user_pic.png')
                : Image.file(File(controller.foto)),
            minRadius: 85,
            maxRadius: 85)),
        StepLines(texto: '1'),
        Obx(() => CustomTextRich(
            titulo: 'Você é: ',
            descricao: controller.tipo == TipoUsuario.PACIENTE
                ? 'Paciente'
                : 'Médico')),
        controller.tipo == TipoUsuario.PACIENTE
            ? Obx(() =>
                CustomTextRich(titulo: 'CPF: ', descricao: controller.cpf))
            : Obx(() => CustomTextRich(
                titulo: 'CRM: ',
                descricao: '${controller.crm} ${controller.crmUf}')),
        StepLines(texto: '2'),
        Obx(() => CustomTextRich(titulo: 'Nome: ', descricao: controller.nome)),
        Obx(() => CustomTextRich(
            titulo: 'Telefone: ', descricao: controller.telefone)),
        Obx(() => CustomTextRich(
            titulo: 'Data de nascimento: ',
            descricao: controller.formataDataNascimento)),
        StepLines(texto: '3'),
        Obx(() =>
            CustomTextRich(titulo: 'E-mail: ', descricao: controller.email)),
        Obx(() => CustomTextRich(
            titulo: 'Gênero: ', descricao: controller.generoName)),
        StepLines(texto: '4'),
        controller.tipo == TipoUsuario.PACIENTE
            ? Column(
                children: [
                  Obx(() => CustomTextRich(
                      titulo: 'Altura: ', descricao: controller.altura)),
                  Obx(() => CustomTextRich(
                      titulo: 'Peso: ', descricao: controller.peso)),
                ],
              )
            : Column(
                children: [
                  Obx(() => CustomTextRich(
                      titulo: 'Especialização: ',
                      descricao: controller.especializacaoName)),
                  Obx(() => CustomTextRich(
                      titulo: 'Descrição: ', descricao: controller.descricao)),
                ],
              ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
