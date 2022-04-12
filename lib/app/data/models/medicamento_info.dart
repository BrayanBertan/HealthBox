import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/core/extensions/enums.dart';

import '../enums/periodicidade_medicamento.dart';
import '../enums/unidade_medida.dart';

class MedicamentoInfo {
  int? id;
  String dose;
  UnidadeMedida unidadeMedida;
  String duracao;
  String intervalo;
  PeriodicidadeMedicamento periodicidadeMedicamento;
  Medicamento medicamento;

  MedicamentoInfo({
    this.id,
    required this.dose,
    required this.unidadeMedida,
    required this.duracao,
    required this.intervalo,
    required this.periodicidadeMedicamento,
    required this.medicamento,
  });

  factory MedicamentoInfo.fromJson(Map<String, dynamic> json) =>
      MedicamentoInfo(
        id: json['id'],
        dose: json['dose'],
        unidadeMedida: json['unidade_medida'].toString().unidadeMedida(),
        duracao: json['duracao'],
        intervalo: json['intervalo'],
        periodicidadeMedicamento:
            json['periodicidade'].toString().periodicidadeMedicamento(),
        medicamento: Medicamento.fromJson(json['remedio']),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "dose": dose,
      "unidade_medida": unidadeMedida.name,
      "duracao": duracao,
      "intervalo": intervalo,
      "periodicidade": periodicidadeMedicamento.name,
      "remedio_id": medicamento.id
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

  static List<Map<String, dynamic>> listToJson(list) {
    return List<Map<String, dynamic>>.from(
        list.map((medicamentoInfo) => medicamentoInfo.toJson()));
  }

  @override
  String toString() {
    return "id: $id";
  }
}
