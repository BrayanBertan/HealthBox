import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/conta.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/app/data/repositories/conta.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';
import 'package:healthbox/app/modules/conta/controller.dart';

import 'dados_usuario/controller.dart';

class ContaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContaProvider>(() => ContaProvider());
    Get.lazyPut<ContaController>(() => ContaController(
        repository: ContaRepository(provider: Get.find<ContaProvider>())));
    Get.lazyPut<DadosUsuarioController>(() => DadosUsuarioController(
        repository: UsuarioRepository(provider: Get.find<UsuarioProvider>())));
  }
}
