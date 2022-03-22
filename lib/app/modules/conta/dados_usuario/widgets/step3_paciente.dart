import 'package:flutter/material.dart';

class Step3PacientePage extends StatelessWidget {
  const Step3PacientePage({Key? key}) : super(key: key);

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
              labelText: "CPF",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
        ),
        TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
              icon: const Icon(
                Icons.height,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Altura",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
        ),
        TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
              icon: const Icon(
                Icons.balance,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Peso",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
