import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/opinioes/widgets/list_opinioes.dart';

import '../../../widgets/filtros/header_filtros.dart';

class CardOpinioes extends StatelessWidget {
  const CardOpinioes({Key? key}) : super(key: key);

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
            const ListOpinioes(),
          ],
        ),
      ),
    );
  }
}
