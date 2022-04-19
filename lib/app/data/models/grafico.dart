class Grafico {
  int id;
  String eixoX;
  int eixoY;
  Grafico({required this.id, required this.eixoX, required this.eixoY});

  factory Grafico.fromJson(Map<String, dynamic> json) =>
      Grafico(id: json['id'], eixoX: json['eixoX'], eixoY: json['eixoY']);

  static List<Grafico> listFromJson(list) {
    return List<Grafico>.from(list.map((grafico) => Grafico.fromJson(grafico)));
  }

  @override
  String toString() {
    // TODO: implement toString
    return "eixoX: $eixoX eixoY: $eixoY";
  }
}
