class Questao {
  int? id;
  int questaoId;
  String? descricao;
  Questao({this.id, required this.questaoId, this.descricao});

  factory Questao.fromJson(Map<String, dynamic> json) => Questao(
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

  static List<Questao> listFromJson(list) =>
      List<Questao>.from(list.map((opcao) => Questao.fromJson(opcao)));

  static List<Map<String, dynamic>> listToJson(list) =>
      List<Map<String, dynamic>>.from(list.map((opcao) => opcao.toJson()));

  @override
  String toString() {
    return "Questao $questaoId $descricao";
  }
}
