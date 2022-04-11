import 'package:healthbox/core/extensions/enums.dart';

import '../enums/periodicidade_medicamento.dart';
import '../enums/unidade_medida.dart';

class MedicamentoInfo {
  int? id;
  int dose;
  UnidadeMedida unidadeMedida;
  int duracao;
  int intervalo;
  PeriodicidadeMedicamento periodicidadeMedicamento;
  int? remedioId;

  MedicamentoInfo({
    this.id,
    required this.dose,
    required this.unidadeMedida,
    required this.duracao,
    required this.intervalo,
    required this.periodicidadeMedicamento,
    required this.remedioId,
  });

  factory MedicamentoInfo.fromJson(Map<String, dynamic> json) =>
      MedicamentoInfo(
        id: json['id'],
        dose: json['dose'],
        unidadeMedida: json['unidadeMedida'].toString().unidadeMedida(),
        duracao: json['duracao'],
        intervalo: json['intervalo'],
        periodicidadeMedicamento: json['periodicidadeMedicamento']
            .toString()
            .periodicidadeMedicamento(),
        remedioId: json['remedio_id'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "dose": dose,
      "unidade_medida": unidadeMedida.name,
      "duracao": duracao,
      "intervalo": intervalo,
      "periodicidade": periodicidadeMedicamento.name,
      "remedio_id": remedioId
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static List<MedicamentoInfo> listFromJson(list) {
    return List<MedicamentoInfo>.from(list
        .map((medicamentoInfo) => MedicamentoInfo.fromJson(medicamentoInfo)));
  }

  static List<MedicamentoInfo> listToJson(list) {
    return List<MedicamentoInfo>.from(
        list.map((medicamentoInfo) => medicamentoInfo.toJson()));
  }

  @override
  String toString() {
    return "id: $id";
  }
}
