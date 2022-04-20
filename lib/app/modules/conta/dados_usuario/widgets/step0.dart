import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/values/keys.dart';
import '../../../../data/enums/tipo_usuario.dart';

class Step0Page extends GetView<DadosUsuarioController> {
  const Step0Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Você é?',
            style: titulo,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => AbsorbPointer(
                  absorbing: controller.isEditing,
                  child: GestureDetector(
                    onTap: () => controller.setTipo(TipoUsuario.PACIENTE),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              color: controller.tipo == TipoUsuario.PACIENTE
                                  ? corPrincipal
                                  : Colors.transparent,
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
                  ),
                )),
            Obx(() => AbsorbPointer(
                  absorbing: controller.isEditing,
                  child: GestureDetector(
                    onTap: () => controller.setTipo(TipoUsuario.MEDICO),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              color: controller.tipo == TipoUsuario.MEDICO
                                  ? corPrincipal
                                  : Colors.transparent,
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
                  ),
                )),
          ],
        ),
        controller.tipo == TipoUsuario.PACIENTE
            ? Obx(() => TextFormField(
                  initialValue: controller.cpf,
                  onChanged: controller.setCpf,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.document_scanner,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      labelText: "CPF",
                      enabledBorder: InputBorder.none,
                      labelStyle: const TextStyle(color: Colors.grey),
                      errorText: controller.cpfErroMensagem),
                ))
            : AbsorbPointer(
                absorbing: controller.isEditing,
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Obx(() => Expanded(
                        flex: 4,
                        child: TextFormField(
                          initialValue: controller.crm,
                          onChanged: controller.setCrm,
                          decoration: InputDecoration(
                              icon: const Icon(
                                Icons.document_scanner,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                              labelText: "CRM",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.grey),
                              errorText: controller.crmErroMensagem),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ))),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 1,
                        child: Obx(() => DropdownButton<String>(
                            value: controller.crmUf,
                            underline: Container(),
                            items: ufs
                                .map((String uf) => DropdownMenuItem<String>(
                                    value: uf, child: Text(uf)))
                                .toList(),
                            onChanged: controller.setCrmUf))),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              )
      ],
    );
  }
}
