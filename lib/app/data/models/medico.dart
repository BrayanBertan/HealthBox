import 'package:healthbox/app/data/models/crm.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/core/extensions/enums.dart';
import 'package:intl/intl.dart';

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
      required Genero genero,
      required String fcmToken,
      bool? respostaPendente})
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
            genero: genero,
            fcmToken: fcmToken,
            respostaPendente: respostaPendente);

  factory Medico.fromJson(Map<String, dynamic> json) => Medico(
      descricao: json['caracteristica']?['descricao'] ?? '',
      crms: Crm.listFromJson(json['crms'] ?? List<Crm>.empty()),
      id: json['id'],
      tipo: json['tipo'].toString().tipoUsuario(),
      nome: json['name'],
      email: json['email'],
      senha: '',
      fcmToken: json['notificacao_token'] ?? '',
      dataNascimento: DateTime.parse(json['data_nascimento']),
      telefone: json['telefone'],
      fotoPath: json['foto_path'],
      genero: json['genero'].toString().genero(),
      ativo: json['ativo'],
      respostaPendente: json['resposta_pendente']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'caracteristicas': {
        'descricao': descricao,
      },
      'crms': Crm.listToJson(crms),
      'tipo': tipo.name[0],
      'name': nome,
      'email': email,
      'password': senha,
      'data_nascimento': DateFormat('yyyy-MM-dd').format(dataNascimento),
      'telefone': telefone,
      'foto_path': fotoPath,
      'ativo': ativo,
      'notificacao_token': fcmToken,
      'sexo': genero.name[0]
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
