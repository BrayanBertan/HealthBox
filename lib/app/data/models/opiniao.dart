class Opiniao {
  int? id;
  String descricao;
  int pacienteId;
  int eficaz;
  int ativo;
  Opiniao(
      {this.id,
      required this.descricao,
      required this.pacienteId,
      required this.eficaz,
      required this.ativo});

  factory Opiniao.fromJson(Map<String, dynamic> json) => Opiniao(
        id: json['id'],
        descricao: json['descricao'],
        pacienteId: json['paciente_id'],
        eficaz: json['eficaz'],
        ativo: json['ativo'],
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
