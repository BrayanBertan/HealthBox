import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ButtonDeletarConta extends GetView<ContaController> {
  const ButtonDeletarConta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Listener(
          onPointerDown: (event) {
            controller.buttonPressed = true;
            controller.confirmandoDeletarConta();
          },
          onPointerUp: (event) => controller.buttonPressed = false,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Deletar conta'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ),
        Obx(() => controller.buttonPressed
            ? Column(
                children: [
                  StepProgressIndicator(
                    padding: 0,
                    totalSteps: 100,
                    currentStep: controller.carregandoDeleta,
                    selectedColor: Colors.red,
                    unselectedColor: Colors.grey,
                    size: 5,
                  ),
                  const Text(
                    'Pressione por 3 segundos para deletar a conta',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            : Container())
      ],
    );
  }
}
