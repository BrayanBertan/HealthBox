import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/paciente.dart';

class Notificacao {
  String titulo;
  String descricao;
  Medico? medico;
  Paciente? paciente;
  Notificacao({
    required this.titulo,
    required this.descricao,
    this.medico,
    this.paciente,
  });

  factory Notificacao.fromJson(RemoteMessage evento) {
    Map<String, dynamic> remetenteMap = jsonDecode(evento.data['remetente']);
    remetenteMap['id'] = remetenteMap['id'] is int
        ? remetenteMap['id']
        : int.parse(remetenteMap['id']);
    remetenteMap['ativo'] = remetenteMap['ativo'] is int
        ? remetenteMap['ativo']
        : int.parse(remetenteMap['ativo']);
    return Notificacao(
        titulo: evento.notification?.title ?? '',
        descricao: evento.notification?.body ?? '',
        medico: remetenteMap == null || remetenteMap['tipo'] != 'M'
            ? null
            : Medico.fromJson(remetenteMap),
        paciente: remetenteMap == null || remetenteMap['tipo'] != 'P'
            ? null
            : Paciente.fromJson(remetenteMap));
  }

  Map<String, dynamic> toJson() => {
        "to":
            'dG5Eov39T66R1CqTd9LYYy:APA91bEKjNF9Gaqqqtxahd2Vwi6aezukJq4_qIIT-hnVaa3s1MsAkiqa0QMtHEC7OvIFdxvk-SWe-noN11UiEvoitYi7vsUyohUZZ0quHZuZKiKeK0fciDSWhnhe5GQishrk9bJb7Wxe',
        "notification": {
          "title": titulo,
          "body": descricao,
          "priority": "high"
        },
        "data": {
          "remetente": medico == null ? paciente!.toJson() : medico!.toJson()
        },
      };

  @override
  String toString() {
    return "a";
  }
}
