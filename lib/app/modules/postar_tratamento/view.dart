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
              child: Stepper(
                currentStep: 0,
                type: StepperType.horizontal,
                steps: <Step>[
                  Step(
                      title: Text(''),
                      content: Step1TratamentoPage(),
                      isActive: true,
                      state: StepState.indexed),
                  Step(
                      title: Text(''),
                      content: Step2TratamentoPage(),
                      isActive: false,
                      state: StepState.indexed),
                  Step(
                      title: Text(''),
                      content: Step1TratamentoPage(),
                      isActive: false,
                      state: StepState.indexed),
                  Step(
                      title: Text(''),
                      content: Step1TratamentoPage(),
                      isActive: false,
                      state: StepState.indexed),
                ],
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              details.onStepCancel!();
                            },
                            style: ElevatedButton.styleFrom(
                                onSurface: corPrincipal300,
                                fixedSize: const Size(150, 50)),
                            child: Text('Anterior')),
                        ElevatedButton(
                            onPressed: () {
                              details.onStepContinue!();
                            },
                            style: ElevatedButton.styleFrom(
                                onSurface: corPrincipal300,
                                fixedSize: const Size(150, 50)),
                            child: Text('Próximo')),
                      ],
                    ),
                  );
                },
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
