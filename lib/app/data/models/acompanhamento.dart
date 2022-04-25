import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/data/models/tratamento.dart';
import 'package:intl/intl.dart';

class Acompanhamento {
  int? id;
  String descricaoPaciente;
  int pacienteId;
  int medicoId;
  int ativo;
  Tratamento? tratamento;
  int quantidadePeriodicidade;
  int diasDuracao;
  Paciente? paciente;
  Medico? medico;
  String? dataInicio;
  Acompanhamento({
    this.id,
    required this.descricaoPaciente,
    required this.pacienteId,
    required this.medicoId,
    required this.ativo,
    this.tratamento,
    required this.quantidadePeriodicidade,
    this.diasDuracao = 0,
    this.paciente,
    this.dataInicio,
  });

  factory Acompanhamento.fromJson(Map<String, dynamic> json) => Acompanhamento(
        id: json['id'],
        descricaoPaciente: json['descricao_paciente'],
        pacienteId: json['paciente_id'],
        medicoId: json['medico_id'],
        ativo: json['ativo'],
        tratamento: json['tratamento'] != null
            ? Tratamento.fromJson(json['tratamento'])
            : null,
        quantidadePeriodicidade: json['quantidade_periodicidade'],
        diasDuracao: json['dias_duracao'],
        paciente: Paciente.fromJson(json['paciente']),
        dataInicio: DateFormat('dd/MM/yyyy HH:mm')
            .format(DateTime.parse(json['data_inicio'])),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "descricao_paciente": descricaoPaciente,
      "paciente_id": pacienteId,
      "medico_id": medicoId,
      "ativo": ativo,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  static List<Acompanhamento> listFromJson(list) {
    print(list['data']);
    return List<Acompanhamento>.from(list['data']
        .map((acompanhamento) => Acompanhamento.fromJson(acompanhamento)));
  }

  static List<Acompanhamento> listToJson(list) {
    return List<Acompanhamento>.from(
        list.map((acompanhamento) => acompanhamento.toJson()));
  }

  @override
  String toString() {
    return "pacienteId: $pacienteId Descrição: $descricaoPaciente";
  }
}
