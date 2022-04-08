import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

class Step2TratamentoPage extends StatelessWidget {
  Step2TratamentoPage({Key? key}) : super(key: key);
  List<String> medicamentos = [
    "Medicamento 0",
    "Medicamento 1",
    "Medicamento 2"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownSearch<String>(
            showSearchBox: true,
            mode: Mode.BOTTOM_SHEET,
            items: medicamentos,
            dropdownSearchDecoration: InputDecoration(
              labelText: 'Medicamentos',
              hintText: 'aaaa',
            ),
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            selectedItem: medicamentos[0]),
        const SizedBox(
          height: 10,
        ),
        Text('Medicamentos selecionados', style: titulo),
        ListView.builder(
            shrinkWrap: true,
            itemCount: medicamentos.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text(medicamentos[index]),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.info),
                  ),
                )),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
