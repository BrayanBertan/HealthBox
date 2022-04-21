class Grafico {
  int id;
  String eixoX;
  double eixoY;
  double? eixoYTemp;
  DateTime? eixoYData;
  String label;
  Grafico(
      {required this.id,
      required this.eixoX,
      required this.eixoY,
      required this.label,
      this.eixoYTemp,
      this.eixoYData});

  factory Grafico.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('eixoY_eficaz')) {
      return Grafico(
          id: json['id'],
          eixoX: json['eixoX'].split('(')[0],
          eixoY: json['eixoY_eficaz'].toDouble(),
          eixoYTemp: json['eixoY_ineficaz'].toDouble(),
          label: json['eixoX'].split('(')[1]);
    }
    if (json.containsKey('data')) {
      return Grafico(
          id: json['id'],
          eixoX: json['eixoX'].split('(')[0],
          eixoY: json['id'],
          eixoYData: json['data'],
          label: json['eixoX'].split('(')[1]);
    } else {
      return Grafico(
          id: json['id'],
          eixoX: json['eixoX'].split('(')[0],
          eixoY: json['eixoY'].toDouble(),
          label: json['eixoX'].split('(')[1]);
    }
  }

  static List<Grafico> listFromJson(list) =>
      List<Grafico>.from(list.map((grafico) => Grafico.fromJson(grafico)));

  @override
  String toString() {
    // TODO: implement toString
    return "eixoX: $eixoX eixoY: $eixoY";
  }
}
