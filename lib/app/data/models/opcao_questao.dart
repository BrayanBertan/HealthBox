class OpcaoQuestao {
  int? id;
  int? questaoId;
  String descricao;
  OpcaoQuestao({this.id, questaoId, required this.descricao});

  factory OpcaoQuestao.fromJson(Map<String, dynamic> json) => OpcaoQuestao(
      id: json['id'],
      questaoId: json['questao_id'],
      descricao: json['descricao']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'questao_id': this.questaoId,
      'descricao': this.descricao,
    };
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static List<OpcaoQuestao> listFromJson(list) => List<OpcaoQuestao>.from(
      list.map((opcao) => OpcaoQuestao.fromJson(opcao)));

  static List<Map<String, dynamic>> listToJson(list) =>
      List<Map<String, dynamic>>.from(list.map((opcao) => opcao.toJson()));

  @override
  String toString() {
    return "OpcaoQuestao $questaoId $descricao";
  }

  @override
  // TODO: implement props
  List<Object?> get props => [descricao];
}
