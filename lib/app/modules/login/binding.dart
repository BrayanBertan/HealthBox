import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/usuario.dart';
import 'package:healthbox/app/data/repositories/usuario.dart';
import 'package:healthbox/app/modules/login/controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    print('2 login binding');
    Get.lazyPut<UsuarioProvider>(() => UsuarioProvider());
    Get.put<LoginController>(
        LoginController(
            repository: UsuarioRepository(
                usuarioProvider: Get.find<UsuarioProvider>())),
        permanent: true);
  }
}
