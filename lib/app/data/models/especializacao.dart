class Especializacao {
  int id;
  String titulo;

  Especializacao({required this.id, required this.titulo});

  factory Especializacao.fromJson(Map<String, dynamic> json) =>
      Especializacao(id: json['id'], titulo: json['titulo']);

  Map<String, dynamic> toJson() => {'id': this.id, 'titulo': this.titulo};

  @override
  String toString() {
    return "id: $id Nome: $titulo";
  }
}
