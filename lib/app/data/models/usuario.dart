import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/especializacao.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/core/extensions/enums.dart';

abstract class Usuario {
  int? id;
  TipoUsuario tipo = TipoUsuario.PACIENTE;
  String nome = '';
  String email = '';
  String senha = '';
  DateTime dataNascimento = DateTime.now();
  String telefone = '';
  String fotoPath = '';
  int ativo = 1;
  Genero genero = Genero.MASCULINO;

  Usuario({required Map<String, dynamic> usuario}) {
    this.id = usuario['id'];
    this.tipo = usuario['tipo'];
    this.nome = usuario['nome'];
    this.email = usuario['email'];
    this.senha = usuario['senha'];
    this.dataNascimento = usuario['dataNascimento'];
    this.telefone = usuario['telefone'];
    this.fotoPath = usuario['fotoPath'];
    this.ativo = usuario['ativo'];
    this.genero = usuario['genero'];
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> usuario = {
      'id': json['id'],
      'tipo': json['tipo'].toString().tipoUsuario(),
      'nome': json['nome'],
      'email': json['email'],
      'senha': json['senha'],
      'dataNascimento': json['data_nascimento'],
      'telefone': json['telefone'],
      'fotoPath': json['fotoPath'],
      'ativo': json['ativo'],
      'genero': json['genero'].toString().genero(),
    };
    return json['tipo'] == TipoUsuario.PACIENTE.name
        ? Paciente(
            cpf: json['cpf'],
            altura: double.parse(json['altura']),
            peso: double.parse(json['peso']),
            usuario: usuario)
        : Medico(
            crm: json['crm'],
            descricao: json['descricao'],
            especializacao: Especializacao.fromJson({
              'id': json['especializacao'].id,
              'titulo': json['especializacao'].titulo
            }),
            usuario: usuario);
  }

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
