import 'package:get/get.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/modules/login/controller.dart';

class Vinculo {
  int? id;
  int usuarioId;
  String nome;
  String? fotoPath;
  Paciente? paciente;
  String? fcmToken;
  static int usuarioAtivoId = 0;
  Vinculo(
      {this.id,
      required this.usuarioId,
      this.fotoPath,
      required this.nome,
      this.fcmToken,
      this.paciente});

  factory Vinculo.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('solicitante')) {
      if (json['solicitante_id'] == usuarioAtivoId) {
        return Vinculo(
          id: json['id'],
          usuarioId: json['solicitado']['id'],
          fotoPath: json['solicitado']['foto_path'],
          nome: json['solicitado']['name'],
          paciente: Paciente.fromJson(json['paciente']),
        );
      } else {
        return Vinculo(
            id: json['id'],
            usuarioId: json['solicitante']['id'],
            fotoPath: json['solicitante']['foto_path'],
            nome: json['solicitante']['name'],
            paciente: Paciente.fromJson(json['paciente']));
      }
    } else {
      return Vinculo(
          usuarioId: json['id'],
          fotoPath: json['foto_path'],
          nome: json['name'],
          fcmToken: json['notificacao_token']);
    }
  }

  static List<Vinculo> listFromJson(list) {
    usuarioAtivoId = Get.find<LoginController>().getLogin().id;
    return List<Vinculo>.from(
        list['data'].map((vinculo) => Vinculo.fromJson(vinculo)));
  }

  @override
  String toString() {
    return nome;
  }
}
