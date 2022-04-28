import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/grid_usuarios_acompanhamentos.dart';

import 'header_filtros.dart';

class CardUsuariosAcompanhamentos extends StatelessWidget {
  const CardUsuariosAcompanhamentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderFiltro(),
            const Divider(),
            const GridUsuariosAcompanhamentos(),
          ],
        ),
      ),
    );
  }
}
