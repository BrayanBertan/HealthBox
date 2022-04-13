import 'package:healthbox/app/data/models/medicamento_info.dart';

class Tratamento {
  int? id;
  int? opiniaoId;
  int? acompanhamentoId;
  String titulo;
  String descricao;
  List<MedicamentoInfo>? medicamentos;

  Tratamento(
      {this.id,
      this.opiniaoId,
      this.acompanhamentoId,
      required this.titulo,
      required this.descricao,
      this.medicamentos});

  factory Tratamento.fromJson(Map<String, dynamic> json) => Tratamento(
      opiniaoId: json['opiniao_id'],
      acompanhamentoId: json['acompanhamento_id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      medicamentos: json['remedios'] == null
          ? List<MedicamentoInfo>.empty()
          : MedicamentoInfo.listFromJson(json['remedios']));

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "titulo": titulo,
      "descricao": descricao,
      "remedios": medicamentos != null
          ? MedicamentoInfo.listToJson(medicamentos)
          : null,
    };
    if (id != null) map['id'] = id;
    if (opiniaoId != null) map["opiniao_id"] = opiniaoId;
    if (acompanhamentoId != null) map["acompanhamento_id"] = acompanhamentoId;

    return map;
  }

  static List<Tratamento> listFromJson(list) {
    return List<Tratamento>.from(list.map((crm) => Tratamento.fromJson(crm)));
  }

  static List<Tratamento> listToJson(list) {
    return List<Tratamento>.from(list.map((crm) => crm.toJson()));
  }

  @override
  String toString() {
    return "id: $opiniaoId $acompanhamentoId Titulo: $titulo  $descricao medicamentos $medicamentos";
  }
}
