import 'package:healthbox/app/data/models/like.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/data/models/tratamento.dart';
import 'package:intl/intl.dart';

class Opiniao {
  int? id;
  String descricao;
  int pacienteId;
  int eficaz;
  int ativo;
  Tratamento? tratamento;
  int totalLike;
  int totalDislike;
  List<Like> likes;
  Paciente? paciente;
  String? dataPostagem;
  String? dataAtualizacao;
  bool utilizado;
  Opiniao(
      {this.id,
      required this.descricao,
      required this.pacienteId,
      required this.eficaz,
      required this.ativo,
      this.tratamento,
      this.totalLike = 0,
      this.totalDislike = 0,
      this.likes = const <Like>[],
      this.paciente,
      this.dataPostagem,
      this.dataAtualizacao,
      required this.utilizado});

  factory Opiniao.fromJson(Map<String, dynamic> json) => Opiniao(
        id: json['id'],
        descricao: json['descricao'],
        pacienteId: json['paciente_id'],
        eficaz: json['eficaz'],
        ativo: json['ativo'],
        utilizado: json['utilizado'],
        tratamento: json['tratamento'] != null
            ? Tratamento.fromJson(json['tratamento'])
            : null,
        totalLike: json['total_like'],
        totalDislike: json['total_dislike'],
        likes: json['likes'] == null
            ? List<Like>.empty()
            : Like.listFromJson(json['likes']),
        paciente: Paciente.fromJson(json['paciente']),
        dataPostagem: DateFormat('dd/MM/yyyy HH:mm').format(
            DateTime.parse(json['created_at'])
                .subtract(const Duration(hours: 3))),
        dataAtualizacao: DateFormat('dd/MM/yyyy HH:mm').format(
            DateTime.parse(json['updated_at'])
                .subtract(const Duration(hours: 3))),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "descricao": descricao,
      "paciente_id": pacienteId,
      "eficaz": eficaz,
      "ativo": ativo,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static List<Opiniao> listFromJson(list) {
    print(list['data']);
    return List<Opiniao>.from(
        list['data'].map((opiniao) => Opiniao.fromJson(opiniao)));
  }

  static List<Opiniao> listToJson(list) {
    return List<Opiniao>.from(list.map((opiniao) => opiniao.toJson()));
  }

  @override
  String toString() {
    return "pacienteId: $pacienteId Descrição: $descricao";
  }
}
