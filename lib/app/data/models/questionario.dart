class Questionario {
  int? id;
  String titulo;
  String? descricao;
  int acompanhamentoId;
  Questionario(
      {this.id,
      required this.titulo,
      this.descricao,
      required this.acompanhamentoId});

  factory Questionario.fromJson(Map<String, dynamic> json) => Questionario(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      acompanhamentoId: json['acompanhamento_id']);

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
    return "Questionario $titulo $descricao";
  }
}
