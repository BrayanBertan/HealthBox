import 'package:healthbox/app/data/enums/tipo_questao.dart';
import 'package:healthbox/app/data/models/opcao_questao.dart';
import 'package:healthbox/core/extensions/enums.dart';

class Questao {
  int? id;
  TipoQuestao tipo;
  String? descricao;
  List<OpcaoQuestao>? opcoes;
  Questao({this.id, required this.tipo, this.descricao});

  factory Questao.fromJson(Map<String, dynamic> json) {
    Questao questao;
    questao = Questao(
      id: json['id'],
      tipo: json['tipo'].toString().tipoQuestao(),
      descricao: json['descricao'],
    );
    if (questao.tipo == TipoQuestao.O) {
      questao.opcoes = json['opcoes'] == null
          ? List<OpcaoQuestao>.empty()
          : OpcaoQuestao.listFromJson(json['opcoes']);
    }
    return questao;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'tipo': this.tipo.name,
      'descricao': this.descricao,
    };

    if (tipo == TipoQuestao.O) {
      map['opcoes'] = opcoes == null || opcoes!.isEmpty
          ? null
          : OpcaoQuestao.listToJson(opcoes);
    }
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static List<Questao> listFromJson(list) =>
      List<Questao>.from(list.map((opcao) => Questao.fromJson(opcao)));

  static List<Map<String, dynamic>> listToJson(list) =>
      List<Map<String, dynamic>>.from(list.map((opcao) => opcao.toJson()));

  @override
  String toString() {
    return "Questao $tipo $descricao";
  }
}
