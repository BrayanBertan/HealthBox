import 'especializacao.dart';

class Crm {
  int? id;
  String crm;
  String estado_sigla;
  List<Especializacao>? especializacoes;
  Crm(
      {this.id,
      required this.crm,
      required this.estado_sigla,
      this.especializacoes});

  factory Crm.fromJson(Map<String, dynamic> json) => Crm(
      id: json['id'],
      crm: json['crm'],
      estado_sigla: json['estado_sigla'],
      especializacoes: json.containsKey('especializacoes')
          ? Especializacao.listFromJson(json['especializacoes'])
          : null);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "crm": crm,
      "estado_sigla": estado_sigla,
      "especializacoes": especializacoes != null
          ? Especializacao.listToJson(especializacoes)
          : null,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static List<Crm> listFromJson(list) {
    return List<Crm>.from(list.map((crm) => Crm.fromJson(crm)));
  }

  static List<Map<String, dynamic>> listToJson(list) =>
      List<Map<String, dynamic>>.from(list.map((crm) => crm.toJson()));

  @override
  String toString() {
    return "id: $id Nome: $crm  $estado_sigla especializações $especializacoes";
  }
}
