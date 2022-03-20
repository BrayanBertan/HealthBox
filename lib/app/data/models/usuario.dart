import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/paciente.dart';

abstract class Usuario {
  int? id;
  TipoUsuario tipo;
  String nome;
  String email;
  String senha;
  DateTime dataNascimento;
  String telefone;
  String fotoPath;
  int ativo;
  Genero genero;

  Usuario(
      {this.id,
      required this.tipo,
      required this.nome,
      required this.email,
      required this.senha,
      required this.dataNascimento,
      required this.telefone,
      required this.fotoPath,
      required this.ativo,
      required this.genero});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      json['tipo'] == TipoUsuario.PACIENTE.name
          ? Paciente(
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
              ativo: json['ativo'])
          : Medico(
              crm: json['crm'],
              descricao: json['descricao'],
              especializacao: json['especializacao'],
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

  static List<Usuario> listFromJson(list) =>
      List<Usuario>.from(list.map((usuario) => Usuario.fromJson(usuario)));

  Map<String, dynamic> retornaBaseMap() {
    Map<String, dynamic> map = {
      'tipo': this.tipo,
      'nome': this.nome,
      'email': this.email,
      'senha': this.senha,
      'data_nascimento': this.dataNascimento,
      'telefone': this.telefone,
      'fotoPath': this.fotoPath,
      'ativo': this.ativo,
      'genero': this.genero
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "id: $id Nome: $nome";
  }
}
