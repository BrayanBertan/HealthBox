class Especializacao {
  int? id;
  int especializacaoId;
  String nome;

  Especializacao({this.id, required this.especializacaoId, required this.nome});

  factory Especializacao.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('especializacao_id')) {
      return Especializacao(
          id: json['id'],
          especializacaoId: json['especializacao_id'],
          nome: json['nome']);
    }
    return Especializacao(especializacaoId: json['id'], nome: json['nome']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'especializacao_id': this.especializacaoId,
      'nome': this.nome
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

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

  static List<Especializacao> listToJson(list) {
    return List<Especializacao>.from(
        list.map((especializacao) => especializacao.toJson()));
  }

  @override
  String toString() {
    return "especialização $especializacaoId $nome";
  }

  @override
  // TODO: implement props
  List<Object?> get props => [nome];
}
