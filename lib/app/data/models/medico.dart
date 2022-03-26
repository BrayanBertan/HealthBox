import 'package:healthbox/app/data/models/especializacao.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/core/extensions/enums.dart';

import '../enums/genero.dart';
import '../enums/tipo_usuario.dart';

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
      especializacao: Especializacao.fromJson({
        'id': json['especializacao'].id,
        'titulo': json['especializacao'].titulo
      }),
      id: json['id'],
      tipo: json['tipo'].toString().tipoUsuario(),
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      dataNascimento: json['data_nascimento'],
      telefone: json['telefone'],
      fotoPath: json['fotoPath'],
      genero: json['genero'].toString().genero(),
      ativo: json['ativo']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'crm': crm,
      'descricao': descricao,
      'especializacao': especializacao,
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
}
