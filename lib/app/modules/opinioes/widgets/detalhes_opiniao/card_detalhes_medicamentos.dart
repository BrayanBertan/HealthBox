import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/dialog_detalhes_medicamentos.dart';

import '../../../../../core/theme/app_colors.dart';

class CardDetalhesMedicamentos extends StatelessWidget {
  const CardDetalhesMedicamentos({Key? key}) : super(key: key);

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
            const Text(
              'Medicamentos utilizados no tratamento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) => ListTile(
                        title: Text('Medicamento $index'),
                        trailing: IconButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) => DialogDetalhesMedicamentos()),
                          icon: const Icon(Icons.info),
                          color: corPrincipal,
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
