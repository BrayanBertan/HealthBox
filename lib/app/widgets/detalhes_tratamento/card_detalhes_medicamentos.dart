import 'package:flutter/material.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/app/widgets/detalhes_tratamento/dialog_detalhes_medicamentos.dart';

import '../../../../../core/theme/app_colors.dart';

class CardDetalhesMedicamentos extends StatelessWidget {
  List<MedicamentoInfo> medicamentos;
  CardDetalhesMedicamentos({required this.medicamentos, Key? key})
      : super(key: key);

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
            medicamentos.isNotEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: medicamentos.length,
                        itemBuilder: (context, index) => ListTile(
                              title: Text(medicamentos[index].medicamento.nome),
                              trailing: IconButton(
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => DialogDetalhesMedicamentos(
                                        medicamento: medicamentos[index])),
                                icon: const Icon(Icons.info),
                                color: corPrincipal,
                              ),
                            )),
                  )
                : const Text(
                    'Nenhum medicamento foi utilizado nesse tratamento')
          ],
        ),
      ),
    );
  }
}
