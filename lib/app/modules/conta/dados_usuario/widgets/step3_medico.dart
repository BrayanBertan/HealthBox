import 'package:flutter/material.dart';
import 'package:healthbox/core/values/keys.dart';

class Step3MedicoPage extends StatelessWidget {
  const Step3MedicoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
              icon: const Icon(
                Icons.document_scanner,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "CRM",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
        ),
        Row(
          children: [
            const Text('Gênero', style: TextStyle(fontSize: 18)),
            const SizedBox(
              width: 15,
            ),
            DropdownButton<String>(
                value: especializacoes[0],
                menuMaxHeight: 250,
                items: especializacoes
                    .map((String especializacao) => DropdownMenuItem<String>(
                        value: especializacao, child: Text(especializacao)))
                    .toList(),
                onChanged: (String? tipo) {})
          ],
        ),
        TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
              icon: const Icon(
                Icons.list_alt_outlined,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Descrição",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
          maxLines: 5,
        ),
      ],
    );
  }
}
