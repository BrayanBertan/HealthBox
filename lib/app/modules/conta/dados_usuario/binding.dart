import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/controller.dart';

class DadosUsuarioBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DadosUsuarioController>(() => DadosUsuarioController());
  }
}
