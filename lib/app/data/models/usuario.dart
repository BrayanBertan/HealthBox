import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';

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
