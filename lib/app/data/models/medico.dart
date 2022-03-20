import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/especializacao.dart';
import 'package:healthbox/app/data/models/usuario.dart';

class Medico extends Usuario {
  String crm;
  String descricao;
  Especializacao especializacao;

  Medico(
      {required this.crm,
      required this.descricao,
      required this.especializacao,
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

  factory Medico.fromJson(Map<String, dynamic> json) => Medico(
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

  Map<String, dynamic> toJson() => {
        ...{
          'crm': this.crm,
          'descricao': this.descricao,
          'especializacao': this.especializacao
        },
        ...retornaBaseMap()
      };
}
