class GraficoMedico {
  int id;
  String eixoX;
  double eixoYMelhorou;
  double eixoYigual;
  double eixoYPiorou;

  GraficoMedico({
    required this.id,
    required this.eixoX,
    required this.eixoYMelhorou,
    required this.eixoYigual,
    required this.eixoYPiorou,
  });

  factory GraficoMedico.fromJson(Map<String, dynamic> json) => GraficoMedico(
      id: json['id'],
      eixoX: json['eixoX'],
      eixoYMelhorou: json['eixoY_melhorou'].toDouble(),
      eixoYigual: json['eixoY_igual'].toDouble(),
      eixoYPiorou: json['eixoY_piorou'].toDouble());

  static List<GraficoMedico> listFromJson(list) => List<GraficoMedico>.from(
      list.map((grafico) => GraficoMedico.fromJson(grafico)));

  @override
  String toString() {
    // TODO: implement toString
    return "eixoX: $eixoX";
  }
}
