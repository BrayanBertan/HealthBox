import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/questionarios/widgets/custom_list_questionario.dart';
import 'package:healthbox/app/widgets/shimmer_graficos.dart';
import 'package:intl/intl.dart';

class CardListagemQuestionarios extends GetView<AcompanhamentosController> {
  const CardListagemQuestionarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.carregando
          ? const ShimmerContainer()
          : ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: controller.questionariosVisualizacao.length,
              itemBuilder: (_, index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                    TextSpan(
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: DateFormat('dd/MM/yyyy').format(controller
                                  .questionariosVisualizacao[index]
                                  .dataResposta!),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: controller.getHistoricoLegenda(controller
                                  .questionariosVisualizacao[index]
                                  .dataResposta!)['legenda']),
                          TextSpan(
                              text: controller.isQuestionarioRespondido(controller
                                  .questionariosVisualizacao[index]
                                  .questoes)['isRespondido'],
                              style: TextStyle(
                                  color: controller.getHistoricoLegenda(controller
                                              .questionariosVisualizacao[index]
                                              .dataResposta!)['legenda'] ==
                                          ' Futuro'
                                      ? Colors.grey
                                      : controller.getHistoricoLegenda(controller.questionariosVisualizacao[index].dataResposta!)[
                                                  'legenda'] ==
                                              ' Aberto'
                                          ? Colors.yellow
                                          : controller.isQuestionarioRespondido(controller
                                              .questionariosVisualizacao[index]
                                              .questoes)['cor'])),
                        ]),
                    textAlign: TextAlign.start,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: IgnorePointer(
                        ignoring: true,
                        child: CustomListQuestionario(
                            questionario:
                                controller.questionariosVisualizacao[index]),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
