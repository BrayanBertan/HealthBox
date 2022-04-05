import 'package:flutter/material.dart';
import 'package:healthbox/app/widgets/filtros/dialog_filtros.dart';

import '../../../core/values/keys.dart';

class HeaderFiltro extends StatelessWidget {
  const HeaderFiltro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Opiniões',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder: (_) => DialogFiltros());
            },
            style: ElevatedButton.styleFrom(primary: Colors.white),
            child: const Text(
              'Minhas opiniões',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Container(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(context: context, builder: (_) => DialogFiltros());
            },
            style: ElevatedButton.styleFrom(primary: Colors.white),
            icon: Image.asset(
              '${baseImagemUrl}filtro.png',
              width: 20,
              fit: BoxFit.cover,
            ),
            label: const Text(
              'Filtros',
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
