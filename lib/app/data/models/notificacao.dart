import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/paciente.dart';

class Notificacao {
  String titulo;
  String descricao;
  Medico? medico;
  Paciente? paciente;
  int tipo;
  int idDestinario;
  String fcmToken;
  Notificacao({
    required this.titulo,
    required this.descricao,
    required this.tipo,
    required this.idDestinario,
    required this.fcmToken,
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
        tipo: int.parse(evento.data['tipo_tela'] ?? '0'),
        idDestinario: int.parse(evento.data['id_destinario'] ?? '0'),
        fcmToken: evento.data['token_destionario'],
        medico: remetenteMap == null || remetenteMap['tipo'] != 'M'
            ? null
            : Medico.fromJson(remetenteMap),
        paciente: remetenteMap == null || remetenteMap['tipo'] != 'P'
            ? null
            : Paciente.fromJson(remetenteMap));
  }

  Map<String, dynamic> toJson() => {
        "to": fcmToken,
        "notification": {
          "title": titulo,
          "body": descricao,
          "priority": "high"
        },
        "data": {
          "remetente": medico == null ? paciente!.toJson() : medico!.toJson(),
          "tipo_tela": tipo,
          "id_destinario": idDestinario,
          "token_destionario": fcmToken,
        },
      };

  @override
  String toString() {
    return "a";
  }
}
