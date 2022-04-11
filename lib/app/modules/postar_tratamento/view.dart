import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/step1.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/step2.dart';

import '../../../../../core/theme/app_colors.dart';

class PagePostarTratamento extends GetView<PostarTratamentoController> {
  PagePostarTratamento({Key? key}) : super(key: key) {
    final opiniao = Get.arguments;
    if (opiniao != null) controller.setOpiniaoEdicao(opiniao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal100,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Obx(
                () => Stepper(
                  currentStep: controller.activeStepIndex,
                  type: StepperType.horizontal,
                  steps: <Step>[
                    Step(
                        title: Text(''),
                        content: Step1TratamentoPage(),
                        isActive: controller.activeStepIndex == 0,
                        state: controller.getStepState(0)),
                    Step(
                        title: Text(''),
                        content: Step2TratamentoPage(),
                        isActive: controller.activeStepIndex == 1,
                        state: controller.getStepState(1)),
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
                              onPressed: () {
                                details.onStepContinue!();
                              },
                              style: ElevatedButton.styleFrom(
                                  onSurface: corPrincipal300,
                                  fixedSize: const Size(150, 50)),
                              child: Text(controller.activeStepIndex == 4
                                  ? 'Confirmar?'
                                  : 'Próximo'))),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            controller.idOpiniao != null
                ? Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => controller.deletarOpiniao(),
                      child: const Text('Deletar opinião'),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
