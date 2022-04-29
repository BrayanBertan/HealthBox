import 'package:flutter/material.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/widgets/ficha_paciente/ficha.dart';

class DialogFichaPaciente extends StatelessWidget {
  Paciente? paciente;
  DialogFichaPaciente({required this.paciente, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FichaPaciente(paciente: paciente),
    );
  }
}
