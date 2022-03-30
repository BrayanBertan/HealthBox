import 'package:flutter/material.dart';

import '../../../../../core/values/keys.dart';

class BarraNovoCrm extends StatelessWidget {
  String titulo;
  String crm;
  String uf;
  IconData icone;
  BarraNovoCrm(
      {this.titulo = 'Novo crm',
      this.crm = '',
      this.uf = 'SC',
      this.icone = Icons.add,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 4,
              child: TextFormField(
                initialValue: crm,
                decoration: InputDecoration(
                    icon: const Icon(
                      Icons.document_scanner,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                    labelText: titulo,
                    enabledBorder: InputBorder.none,
                    labelStyle: const TextStyle(color: Colors.grey)),
              )),
          Expanded(
              flex: 1,
              child: DropdownButton<String>(
                  value: uf,
                  items: ufs
                      .map((String uf) =>
                          DropdownMenuItem<String>(value: uf, child: Text(uf)))
                      .toList(),
                  onChanged: (uf) {})),
          IconButton(
            onPressed: () {},
            icon: Icon(icone),
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
