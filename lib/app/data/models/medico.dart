import 'package:healthbox/app/data/models/crm.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/core/extensions/enums.dart';

import '../enums/genero.dart';
import '../enums/tipo_usuario.dart';

class Medico extends Usuario {
  String descricao;
  List<Crm> crms;

  Medico(
      {required this.descricao,
      required this.crms,
      int? id,
      required TipoUsuario tipo,
      required String nome,
      required String email,
      required String senha,
      required DateTime dataNascimento,
      required String telefone,
      String? fotoPath,
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

  factory Medico.fromJson(Map<String, dynamic> json) {
    print('aquiiiiiiiiiiiiiiiiiiiiiiiii $json');
    return Medico(
        descricao: json['caracteristica']['descricao'],
        crms: Crm.listFromJson(json['crms']),
        id: json['id'],
        tipo: json['tipo'].toString().tipoUsuario(),
        nome: json['name'],
        email: json['email'],
        senha: '',
        dataNascimento: DateTime.parse(json['data_nascimento']),
        telefone: json['telefone'],
        fotoPath: json['foto_path'],
        genero: json['genero'].toString().genero(),
        ativo: json['ativo']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'crms': Crm.listToJson(crms),
      'descricao': this.descricao,
      'tipo': this.tipo,
      'name': this.nome,
      'email': this.email,
      'password': this.senha,
      'data_nascimento': this.dataNascimento,
      'telefone': this.telefone,
      'foto_path': this.fotoPath,
      'ativo': this.ativo,
      'genero': this.genero
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static List<Medico> listFromJson(list) {
    return List<Medico>.from(list.map((medico) => Medico.fromJson(medico)));
  }

  @override
  String toString() {
    return "crms $crms";
  }
}
