import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/app/data/models/usuario.dart';

class Questionario {
  int? id;
  String titulo;
  String? descricao;
  int acompanhamentoId;
  List<Questao>? questoes;
  DateTime? dataResposta;
  bool? respostaPendente;
  Usuario? usuarioVinculado;
  Questionario(
      {this.id,
      required this.titulo,
      this.descricao,
      required this.acompanhamentoId,
      this.questoes,
      this.dataResposta,
      this.respostaPendente,
      this.usuarioVinculado});

  factory Questionario.fromJson(Map<String, dynamic> json) => Questionario(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      acompanhamentoId: json['acompanhamento_id'],
      questoes: Questao.listFromJson(json['questoes']),
      dataResposta: json['data_resposta'] == null
          ? null
          : DateTime.parse(json['data_resposta']),
      respostaPendente: json['resposta_pendente'],
      usuarioVinculado: json['usuario_vinculado'] == null
          ? null
          : json['usuario_vinculado']['tipo'] == 'M'
              ? Medico.fromJson(json['usuario_vinculado'])
              : Paciente.fromJson(json['usuario_vinculado']));

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'titulo': this.titulo,
      'descricao': this.descricao,
      'acompanhamento_id': acompanhamentoId,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static List<Questionario> listFromJson(list) => List<Questionario>.from(
      list.map((opcao) => Questionario.fromJson(opcao)));

  static List<Map<String, dynamic>> listToJson(list) =>
      List<Map<String, dynamic>>.from(list.map((opcao) => opcao.toJson()));

  @override
  String toString() {
    return "Questionario $titulo $descricao questoes $questoes";
  }
}
