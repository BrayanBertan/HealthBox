import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/controller.dart';

class Vinculo {
  int? id;
  int usuarioId;
  String nome;
  String? fotoPath;
  static int usuarioAtivoId = 0;
  Vinculo(
      {this.id, required this.usuarioId, this.fotoPath, required this.nome});

  factory Vinculo.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('solicitante')) {
      if (json['solicitante_id'] == usuarioAtivoId) {
        return Vinculo(
            id: json['id'],
            usuarioId: json['solicitado']['id'],
            fotoPath: json['solicitado']['foto_path'],
            nome: json['solicitado']['name']);
      } else {
        return Vinculo(
            id: json['id'],
            usuarioId: json['solicitante']['id'],
            fotoPath: json['solicitante']['foto_path'],
            nome: json['solicitante']['name']);
      }
    } else {
      return Vinculo(
          usuarioId: json['id'],
          fotoPath: json['foto_path'],
          nome: json['name']);
    }
  }

  static List<Vinculo> listFromJson(list) {
    usuarioAtivoId = Get.find<ContaController>().usuario.id;
    return List<Vinculo>.from(
        list['data'].map((vinculo) => Vinculo.fromJson(vinculo)));
  }

  @override
  String toString() {
    return "Vinculo $nome $fotoPath";
  }
}
