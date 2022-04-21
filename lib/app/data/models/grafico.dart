class Grafico {
  int id;
  String eixoX;
  int eixoY;
  int? eixoYTemp;
  String label;
  Grafico(
      {required this.id,
      required this.eixoX,
      required this.eixoY,
      required this.label,
      this.eixoYTemp});

  factory Grafico.fromJson(Map<String, dynamic> json) {
    return Grafico(
        id: json['id'],
        eixoX: json['label'].split('(')[0],
        eixoY: json['percent'].round(),
        label: json['label'].split('(')[1]);
    if (json.containsKey('eixoY_eficaz')) {
      return Grafico(
          id: json['id'],
          eixoX: json['eixoX'].split('(')[0],
          eixoY: json['eixoY_eficaz'],
          eixoYTemp: json['eixoY_ineficaz'],
          label: json['eixoX'].split('(')[1]);
    } else {
      return Grafico(
          id: json['id'],
          eixoX: json['eixoX'].split('(')[0],
          eixoY: json['eixoY'],
          label: json['eixoX'].split('(')[1]);
    }
  }

  static List<Grafico> listFromJson(list) {
    // print(list);
    // List<Grafico>.from(list.map((grafico) => Grafico.fromJson(grafico)));
    // return List<Grafico>.empty();
    return List<Grafico>.from(list.map((grafico) => Grafico.fromJson(grafico)));
  }

  @override
  String toString() {
    // TODO: implement toString
    return "eixoX: $eixoX eixoY: $eixoY";
  }
}
