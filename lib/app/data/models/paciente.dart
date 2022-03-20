import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/usuario.dart';

class Paciente extends Usuario {
  double altura;
  double peso;
  String cpf;

  Paciente(
      {required this.altura,
      required this.peso,
      required this.cpf,
      int? id,
      required TipoUsuario tipo,
      required String nome,
      required String email,
      required String senha,
      required DateTime dataNascimento,
      required String telefone,
      required String fotoPath,
      required int ativo,
      required Genero genero})
      : super(
            id: id,
            tipo: tipo,
            nome: nome,
            email: email,
            senha: senha,
            dataNascimento: dataNascimento,
            telefone: telefone,
            fotoPath: fotoPath,
            ativo: ativo,
            genero: genero);

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
      cpf: json['cpf'],
      altura: json['altura'],
      peso: json['peso'],
      id: json['id'],
      tipo: json['tipo'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      dataNascimento: json['data_nascimento'],
      telefone: json['telefone'],
      fotoPath: json['fotoPath'],
      genero: json['genero'],
      ativo: json['ativo']);

  Map<String, dynamic> toJson() => {
        ...{'altura': this.altura, 'peso': this.peso, 'cpf': this.cpf},
        ...retornaBaseMap()
      };
}
