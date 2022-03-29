import 'package:get/get.dart';
import 'package:healthbox/app/data/models/crm.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';

import '../login/controller.dart';

class ContaController extends GetxController {
  final UsuarioRepository repository;
  final loginController = Get.find<LoginController>();
  dynamic usuario;

  ContaController({required this.repository}) : assert(repository != null) {
    usuario = loginController.getLogin();
    if (usuario is Medico) {
      crms.clear();
      crms.assignAll(usuario.crms);
    }
  }

  final crms = <Crm>[].obs;
}
