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

  Map<String, dynamic> toJson() => {
        ...{
          'crm': this.crm,
          'descricao': this.descricao,
          'especializacao': this.especializacao
        },
        ...retornaBaseMap()
      };
}
