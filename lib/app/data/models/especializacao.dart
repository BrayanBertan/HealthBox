class Especializacao {
  int id;
  String nome;

  Especializacao({required this.id, required this.nome});

  factory Especializacao.fromJson(Map<String, dynamic> json) =>
      Especializacao(id: json['id'], nome: json['nome']);

  Map<String, dynamic> toJson() => {'id': this.id, 'titulo': this.nome};

  static List<Especializacao> listFromJson(list) {
    var tempList;
    if (list[0] == null) {
      tempList = list['data'];
    } else {
      tempList = list;
    }

    return List<Especializacao>.from(tempList
        .map((especializacao) => Especializacao.fromJson(especializacao)));
  }

  @override
  String toString() {
    return "id: $id Nome: $nome";
  }
}
