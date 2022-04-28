import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/list_acompanhamentos.dart';

import 'header_filtros.dart';

class CardAcompanhamentos extends StatelessWidget {
  const CardAcompanhamentos({Key? key}) : super(key: key);

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
            const ListAcompanhamentos(),
          ],
        ),
      ),
    );
  }
}
