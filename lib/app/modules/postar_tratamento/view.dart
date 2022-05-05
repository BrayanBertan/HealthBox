import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/step0_medico.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/step1.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/step2.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/step3_medico.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/step4_medico.dart';
import 'package:healthbox/app/widgets/ficha_paciente/dialog_ficha.dart';

import '../../../../../core/theme/app_colors.dart';

class PagePostarTratamento extends GetView<PostarTratamentoController> {
  PagePostarTratamento({Key? key}) : super(key: key) {
    final tratamento = Get.arguments;
    if (tratamento != null)
      tratamento is Opiniao
          ? controller.setEdicaoOpiniao(tratamento)
          : controller.setEdicaoAcompanhamento(tratamento);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal100,
      appBar: AppBar(
        title: Text(controller.usuario.tipo == TipoUsuario.PACIENTE
            ? 'Opinião'
            : 'Acompanhamento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.82,
              child: Obx(
                () => Stepper(
                  currentStep: controller.activeStepIndex,
                  type: StepperType.horizontal,
                  steps: controller.isPaciente
                      ? <Step>[
                          Step(
                              title: const Text(''),
                              content: Step1TratamentoPage(),
                              isActive: controller.activeStepIndex == 0,
                              state: controller.getStepState(0)),
                          Step(
                              title: const Text(''),
                              content: Step2TratamentoPage(),
                              isActive: controller.activeStepIndex == 1,
                              state: controller.getStepState(1)),
                        ]
                      : <Step>[
                          Step(
                              title: const Text(''),
                              content: Step0MedicoTratamentoPage(),
                              isActive: controller.activeStepIndex == 0,
                              state: controller.getStepState(0)),
                          Step(
                              title: const Text(''),
                              content: Step1TratamentoPage(),
                              isActive: controller.activeStepIndex == 1,
                              state: controller.getStepState(1)),
                          Step(
                              title: const Text(''),
                              content: Step2TratamentoPage(),
                              isActive: controller.activeStepIndex == 2,
                              state: controller.getStepState(2)),
                          Step(
                              title: const Text(''),
                              content: Step3MedicoTratamentoPage(),
                              isActive: controller.activeStepIndex == 3,
                              state: controller.getStepState(3)),
                          Step(
                              title: const Text(''),
                              content: Step4MedicoTratamentoPage(),
                              isActive: controller.activeStepIndex == 4,
                              state: controller.getStepState(4)),
                        ],
                  onStepCancel: controller.activeStepIndexDecrease,
                  onStepContinue: controller.activeStepIndexIncrease,
                  onStepTapped: (int step) {
                    FocusScope.of(context).unfocus();
                    controller.setActiveStepIndex(step);
                  },
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Obx(() => ElevatedButton(
                              onPressed: controller.activeStepIndex < 1
                                  ? null
                                  : details.onStepCancel,
                              style: ElevatedButton.styleFrom(
                                  onSurface: corPrincipal300,
                                  fixedSize: const Size(150, 50)),
                              child: const Text('Anterior'))),
                          Obx(() => ElevatedButton(
                              onPressed: !controller
                                      .isValidStep(controller.activeStepIndex)
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (controller.isPaciente &&
                                          controller.activeStepIndex == 1) {
                                        controller.salvarOpiniao();
                                        return;
                                      }
                                      if (!controller.isPaciente &&
                                          controller.activeStepIndex == 4) {
                                        controller.salvarAcompanhamento();
                                        return;
                                      }
                                      details.onStepContinue!();
                                    },
                              style: ElevatedButton.styleFrom(
                                  onSurface: corPrincipal300,
                                  fixedSize: const Size(150, 50)),
                              child: Text(controller.isPaciente
                                  ? controller.activeStepIndex == 1
                                      ? 'Salvar'
                                      : 'Próximo'
                                  : controller.activeStepIndex == 4
                                      ? 'Salvar'
                                      : 'Próximo'))),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  controller.idPostagem != null
                      ? TextButton.icon(
                          onPressed: controller.usuario.tipo ==
                                      TipoUsuario.MEDICO &&
                                  controller.checkDataInicial()
                              ? null
                              : () =>
                                  controller.usuario.tipo != TipoUsuario.MEDICO
                                      ? controller.deletarOpiniao()
                                      : controller.deletarAcompanhamento(),
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          label: Text(
                              controller.usuario.tipo != TipoUsuario.MEDICO
                                  ? 'Deletar opinião'
                                  : 'Deletar acompanhamento',
                              style: const TextStyle(color: Colors.red)))
                      : Container(),
                  controller.usuario.tipo != TipoUsuario.MEDICO ||
                          controller.vinculo == null
                      ? Container()
                      : TextButton.icon(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) => DialogFichaPaciente(
                                  paciente: controller.vinculo?.paciente)),
                          icon: const Icon(Icons.list_alt_outlined),
                          label: const Text(
                            'ficha do paciente',
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
