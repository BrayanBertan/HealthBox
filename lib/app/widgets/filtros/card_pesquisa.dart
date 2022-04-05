import 'package:flutter/material.dart';

class CardPesquisa extends StatelessWidget {
  const CardPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pesquise opiniões sobre medicamentos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(),
                labelText: "Pesquisar opiniões",
                labelStyle: const TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
