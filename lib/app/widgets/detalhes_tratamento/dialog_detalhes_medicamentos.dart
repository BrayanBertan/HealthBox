import 'package:flutter/material.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class DialogDetalhesMedicamentos extends StatelessWidget {
  MedicamentoInfo medicamento;
  DialogDetalhesMedicamentos({required this.medicamento, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              (medicamento.medicamento.nome),
              style: titulo,
              textAlign: TextAlign.center,
            ),
            Text.rich(
              TextSpan(
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Fabricado por:  ', style: subTitulo),
                    TextSpan(
                        text: medicamento.medicamento.fabricante,
                        style: TextStyle(
                            color: corPrincipal, fontWeight: FontWeight.bold)),
                  ]),
              textAlign: TextAlign.start,
            ),
            Text.rich(
              TextSpan(
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Dose preescrita:  ', style: subTitulo),
                    TextSpan(
                        text:
                            '${medicamento.dose}${medicamento.unidadeMedida.name}  a cada ${medicamento.intervalo} ${medicamento.periodicidadeMedicamento.name} por ${medicamento.duracao} dias',
                        style: TextStyle(
                            color: corPrincipal, fontWeight: FontWeight.bold)),
                  ]),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
