import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class DialogDetalhesMedicamentos extends StatelessWidget {
  const DialogDetalhesMedicamentos({Key? key}) : super(key: key);

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
              ('Medicamento 1'),
              style: titulo,
              textAlign: TextAlign.center,
            ),
            Text.rich(
              TextSpan(
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Fabricado por  ', style: subTitulo),
                    TextSpan(
                        text: 'Medly',
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
                    TextSpan(text: 'Dose preescrita  ', style: subTitulo),
                    TextSpan(
                        text: '10mg 1 vez ao dia por 30 dias',
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
                    TextSpan(text: 'Link da bula ', style: subTitulo),
                    TextSpan(
                        text: 'www.bula.com.br',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ]),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
