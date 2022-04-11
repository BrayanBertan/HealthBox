import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthbox/app/data/enums/unidade_medida.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../../data/enums/periodicidade_medicamento.dart';

class DialogInfoMedicamento extends StatelessWidget {
  Medicamento medicamento;
  DialogInfoMedicamento({required this.medicamento, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              medicamento.nome,
              style: subTitulo,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Dose ',
                  style: TextStyle(
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      isDense: false,
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                Container(
                  width: 65,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: DropdownButton<UnidadeMedida>(
                      isDense: false,
                      value: UnidadeMedida.MG,
                      items: UnidadeMedida.values
                          .map((UnidadeMedida unidadeMedida) =>
                              DropdownMenuItem<UnidadeMedida>(
                                value: unidadeMedida,
                                child: Text(unidadeMedida.name),
                              ))
                          .toList(),
                      onChanged: (UnidadeMedida? val) => print),
                ),
                Text(
                  'a cada ',
                  style: TextStyle(
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      isDense: false,
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                Container(
                  width: 75,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: DropdownButton<PeriodicidadeMedicamento>(
                      isDense: false,
                      value: PeriodicidadeMedicamento.horas,
                      items: PeriodicidadeMedicamento.values
                          .map((PeriodicidadeMedicamento unidadeMedida) =>
                              DropdownMenuItem<PeriodicidadeMedicamento>(
                                value: unidadeMedida,
                                child: Text(unidadeMedida.name),
                              ))
                          .toList(),
                      onChanged: (PeriodicidadeMedicamento? val) => print),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'por ',
                  style: TextStyle(
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      isDense: false,
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'dias ',
                  style: TextStyle(
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.white),
                icon: Icon(
                  Icons.add,
                  color: Colors.green,
                ),
                label: const Text(
                  'Salvar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
