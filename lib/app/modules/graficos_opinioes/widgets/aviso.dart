import 'package:flutter/material.dart';

class Aviso extends StatelessWidget {
  const Aviso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 50,
        ),
        Card(
          child: Center(
            child: Text(
              'Esses dados são baseados em opiniões feitas por outros pacientes e devem ser usadas apenas para fins de comparação, não se  Automedique, procure um médico.',
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
