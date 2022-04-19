class Grafico {
  int id;
  String eixoX;
  int eixoY;
  String label;
  Grafico(
      {required this.id,
      required this.eixoX,
      required this.eixoY,
      required this.label});

  factory Grafico.fromJson(Map<String, dynamic> json) => Grafico(
      id: json['id'],
      eixoX: json['eixoX'].split('(')[0],
      eixoY: json['eixoY'],
      label: json['eixoX'].split('(')[1]);

  static List<Grafico> listFromJson(list) {
    return List<Grafico>.from(list.map((grafico) => Grafico.fromJson(grafico)));
  }

  @override
  String toString() {
    // TODO: implement toString
    return "eixoX: $eixoX eixoY: $eixoY";
  }
}
