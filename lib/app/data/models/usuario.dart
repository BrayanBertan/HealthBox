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
  String? fotoPath;
  int ativo;
  Genero genero;
  bool? respostaPendente;
  String fcmToken;
  Usuario(
      {this.id,
      required this.tipo,
      required this.nome,
      required this.email,
      required this.senha,
      required this.dataNascimento,
      required this.telefone,
      this.fotoPath,
      required this.ativo,
      required this.genero,
      required this.fcmToken,
      this.respostaPendente});

  @override
  String toString() {
    return "id: $id Nome: $nome";
  }
}
