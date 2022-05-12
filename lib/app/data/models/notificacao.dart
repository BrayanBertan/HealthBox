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
            'uERXJW_BoAF:APA91bH3XlCH4kSC0nqyo4Nbwd8DI2kUVeoNcKGoxq80svHhIFuuge_ZeCZ4gfgaRNZ65o4LWGykkRQb5qgNBoAeRszSi1pk21XjQMA0kKA3tmTL8Bz1wnr0ZgEZZ7Vlk7ht5AI11GAs',
        "notification": {"title": titulo, "body": descricao},
        "data": {
          "remetente": medico == null ? paciente!.toJson() : medico!.toJson()
        },
      };

  @override
  String toString() {
    return "a";
  }
}
