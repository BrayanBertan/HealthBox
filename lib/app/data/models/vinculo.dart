class Vinculo {
  int? id;
  int usuarioId;
  String nome;
  String? fotoPath;

  Vinculo(
      {this.id, required this.usuarioId, this.fotoPath, required this.nome});

  factory Vinculo.fromJson(Map<String, dynamic> json) => Vinculo(
      id: json['id'],
      usuarioId: json['id'],
      fotoPath: json['foto_path'],
      nome: json['name']);

  static List<Vinculo> listFromJson(list) => List<Vinculo>.from(
      list['data'].map((vinculo) => Vinculo.fromJson(vinculo)));

  @override
  String toString() {
    return "Vinculo $nome $fotoPath";
  }
}
