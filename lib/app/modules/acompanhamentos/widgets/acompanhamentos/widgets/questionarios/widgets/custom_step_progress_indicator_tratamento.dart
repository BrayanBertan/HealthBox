import 'package:flutter/material.dart';
import 'package:healthbox/app/data/models/acompanhamento.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CustomStepProgressIndicatorTratamento extends StatelessWidget {
  Acompanhamento acompanhamento;
  CustomStepProgressIndicatorTratamento(
      {required this.acompanhamento, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Progresso do tratamento'),
        Row(
          children: [
            Text(
              '${DateFormat('dd/MM/yyyy').format(acompanhamento.dataInicio)} ',
            ),
            Expanded(
              child: StepProgressIndicator(
                padding: 0,
                totalSteps: 100,
                currentStep:
                    acompanhamento.porcentagemConclusaoQuestionarios?.round() ??
                        0,
                size: 15,
                selectedColor: Colors.green,
                unselectedColor: Colors.grey,
                roundedEdges: const Radius.circular(5),
              ),
            ),
            Text(
              ' ${DateFormat('dd/MM/yyyy').format(acompanhamento.dataInicio.add(Duration(days: acompanhamento.diasDuracao * acompanhamento.quantidadePeriodicidade)))}',
            ),
          ],
        ),
      ],
    );
  }
}
