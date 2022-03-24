import 'package:healthbox/app/data/models/usuario.dart';

class Paciente extends Usuario {
  double altura;
  double peso;
  String cpf;

  Paciente(
      {required this.altura,
      required this.peso,
      required this.cpf,
      required Map<String, dynamic> usuario})
      : super(usuario: usuario);

  Map<String, dynamic> toJson() => {
        ...{'altura': this.altura, 'peso': this.peso, 'cpf': this.cpf},
        ...retornaBaseMap()
      };
}
