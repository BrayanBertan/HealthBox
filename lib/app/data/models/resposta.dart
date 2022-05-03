class Resposta {
  int? id;
  String? respostaDescritiva;
  int? opcaoId;
  Resposta({this.id, required this.respostaDescritiva, required this.opcaoId});

  factory Resposta.fromJson(Map<String, dynamic> json) => Resposta(
      id: json['id'],
      respostaDescritiva: json['resposta_descritiva'],
      opcaoId: json['opcao_id']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'opcao_id': this.opcaoId,
      'resposta_descritiva': this.respostaDescritiva,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static List<Resposta> listFromJson(list) =>
      List<Resposta>.from(list.map((resposta) => Resposta.fromJson(resposta)));

  static List<Map<String, dynamic>> listToJson(list) =>
      List<Map<String, dynamic>>.from(
          list.map((resposta) => resposta.toJson()));

  @override
  String toString() {
    return "Resposta $respostaDescritiva $opcaoId";
  }
}
