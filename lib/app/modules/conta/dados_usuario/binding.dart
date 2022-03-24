import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';

import '../../../data/providers/usuario.dart';
import '../../../data/repositories/usuario.dart';

class DadosUsuarioBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DadosUsuarioController>(() => DadosUsuarioController(
        repository: UsuarioRepository(provider: Get.find<UsuarioProvider>())));
  }
}
