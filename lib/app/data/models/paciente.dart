import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/core/extensions/enums.dart';
import 'package:intl/intl.dart';

import '../enums/genero.dart';
import '../enums/tipo_usuario.dart';

class Paciente extends Usuario {
  double altura;
  double peso;
  String cpf;
  String comorbidades;
  String alergiasMedicamentosas;
  String preDisposicaoGenetica;
  Paciente(
      {required this.altura,
      required this.peso,
      required this.cpf,
      required this.comorbidades,
      required this.alergiasMedicamentosas,
      required this.preDisposicaoGenetica,
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

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
      cpf: json['caracteristica']?['cpf'] ?? '',
      altura: double.parse('${json['caracteristica']?['altura'] ?? '0.0'}'),
      peso: double.parse('${json['caracteristica']?['peso'] ?? '0.0'}'),
      comorbidades: json['caracteristica']?['comorbidades'] ?? '',
      alergiasMedicamentosas:
          json['caracteristica']?['alergias_remedios'] ?? '',
      preDisposicaoGenetica: json['caracteristica']?['pre_disposicoes'] ?? '',
      id: json['id'],
      tipo: json['tipo'].toString().tipoUsuario(),
      nome: json['name'] ?? '',
      email: json['email'],
      senha: '',
      fcmToken: json['notificacao_token'] ?? '',
      dataNascimento: DateTime.parse(json['data_nascimento']),
      telefone: json['telefone'],
      fotoPath: json['foto_path'],
      genero: json['sexo'].toString().genero(),
      ativo: json['ativo'],
      respostaPendente: json['resposta_pendente']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'caracteristicas': {
        'cpf': cpf,
        'altura': altura,
        'peso': peso,
        'comorbidades': comorbidades,
        'alergias_remedios': alergiasMedicamentosas,
        'pre_disposicoes': preDisposicaoGenetica,
      },
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

  static List<Paciente> listFromJson(list) {
    return List<Paciente>.from(
        list.map((paciente) => Paciente.fromJson(paciente)));
  }
}
