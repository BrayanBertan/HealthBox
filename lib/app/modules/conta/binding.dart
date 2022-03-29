import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';
import 'package:healthbox/app/modules/conta/controller.dart';

class ContaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContaController>(() => ContaController(
        repository: UsuarioRepository(provider: Get.find<UsuarioProvider>())));
  }
}
