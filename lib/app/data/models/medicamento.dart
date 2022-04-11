class Medicamento {
  int? id;
  String nome;
  String fabricante;
  String bula;

  Medicamento(
      {this.id,
      required this.nome,
      required this.fabricante,
      required this.bula});

  factory Medicamento.fromJson(Map<String, dynamic> json) => Medicamento(
      id: json['id'],
      nome: json['nome'],
      fabricante: json['fabricante'],
      bula: json['hash_pdf_bula']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "nome": nome,
      "fabricante": fabricante,
      "hash_pdf_bula": bula,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static List<Medicamento> listFromJson(list) {
    if (list['data'] == null || list['data'].isEmpty)
      return List<Medicamento>.empty();
    return List<Medicamento>.from(
        list['data'].map((nome) => Medicamento.fromJson(nome)));
  }

  static List<Medicamento> listToJson(list) {
    return List<Medicamento>.from(list.map((nome) => nome.toJson()));
  }

  String userAsString() {
    return '#${this.id} ${this.nome}';
  }

  bool isEqual(Medicamento model) {
    return this.id == model.id;
  }

  @override
  String toString() => '$nome - ($fabricante)';
}
