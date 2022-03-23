class Especializacao {
  int id;
  String titulo;

  Especializacao({required this.id, required this.titulo});

  factory Especializacao.fromJson(Map<String, dynamic> json) =>
      Especializacao(id: json['id'], titulo: json['titulo']);

  Map<String, dynamic> toJson() => {'id': this.id, 'titulo': this.titulo};

  static List<Especializacao> listFromJson(list) => List<Especializacao>.from(
      list.map((especializacao) => Especializacao.fromJson(especializacao)));

  @override
  String toString() {
    return "id: $id Nome: $titulo";
  }
}
