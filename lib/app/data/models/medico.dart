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
      required Map<String, dynamic> usuario})
      : super(usuario: usuario);

  Map<String, dynamic> toJson() => {
        ...{
          'crm': this.crm,
          'descricao': this.descricao,
          'especializacao_id': this.especializacao.id
        },
        ...retornaBaseMap()
      };
}
