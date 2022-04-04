import 'package:flutter/material.dart';

import '../../../widgets/add_vinculo_dialog.dart';

class TileNovoVinculo extends StatelessWidget {
  const TileNovoVinculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(context: context, builder: (_) => DialogAddVinculo());
      },
      leading: const Icon(Icons.person_add),
      title: const Text('Novo vínculo'),
    );
  }
}
