import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/step1.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/step2.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/step3_medico.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/step3_paciente.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/step4.dart';

import '../../../../core/theme/app_colors.dart';

class DadosUsuarioPage extends GetView<DadosUsuarioController> {
  const DadosUsuarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        physics: ScrollPhysics(),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth,
              height: 1000,
              child: Obx(() {
                return Stepper(
                  currentStep: controller.activeStepIndex,
                  type: StepperType.horizontal,
                  steps: <Step>[
                    Step(
                        title: Text(''),
                        content: Step1Page(),
                        isActive: controller.activeStepIndex == 0,
                        state: controller.getStepState(0)),
                    Step(
                        title: Text(''),
                        content: Step2Page(),
                        isActive: controller.activeStepIndex == 1,
                        state: controller.getStepState(1)),
                    Step(
                        title: Text(''),
                        content: controller.tipo == TipoUsuario.PACIENTE
                            ? Step3PacientePage()
                            : Step3MedicoPage(),
                        isActive: controller.activeStepIndex == 2,
                        state: controller.getStepState(2)),
                    Step(
                        title: Text(''),
                        content: Step4Page(),
                        isActive: controller.activeStepIndex == 3,
                        state: controller.getStepState(3)),
                  ],
                  onStepCancel: controller.activeStepIndexDecrease,
                  onStepContinue: controller.activeStepIndexIncrease,
                  onStepTapped: controller.setActiveStepIndex,
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
                              onPressed: controller.activeStepIndex > 4 ||
                                      !controller.isValidStep(
                                          controller.activeStepIndex)
                                  ? null
                                  : details.onStepContinue,
                              style: ElevatedButton.styleFrom(
                                  onSurface: corPrincipal300,
                                  fixedSize: const Size(150, 50)),
                              child: const Text('Proximo'))),
                        ],
                      ),
                    );
                  },
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
