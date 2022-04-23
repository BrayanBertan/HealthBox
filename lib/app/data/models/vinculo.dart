class Vinculo {
  int? id;
  int usuarioId;
  String nome;
  String? fotoPath;
  Vinculo(
      {this.id, required this.usuarioId, this.fotoPath, required this.nome});

  factory Vinculo.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('solicitante')) {
      return Vinculo(
          id: json['id'],
          usuarioId: json['solicitante']['id'],
          fotoPath: json['solicitante']['foto_path'],
          nome: json['solicitante']['name']);
    } else {
      return Vinculo(
          usuarioId: json['id'],
          fotoPath: json['foto_path'],
          nome: json['name']);
    }
  }

  static List<Vinculo> listFromJson(list) {
    print(list);
    return List<Vinculo>.from(
        list['data'].map((vinculo) => Vinculo.fromJson(vinculo)));
  }

  @override
  String toString() {
    return "Vinculo $nome $fotoPath";
  }
}
