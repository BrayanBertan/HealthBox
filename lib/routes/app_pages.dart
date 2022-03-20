import 'package:get/get.dart';
import 'package:healthbox/app/modules/home/view.dart';
import 'package:healthbox/app/modules/login/view.dart';
import 'package:healthbox/routes/middlewares/autentica_usuario.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.INITIAL,
        page: () => HomePage(),
        middlewares: [AutenticaUsuario()]),
    GetPage(name: Routes.LOGIN, page: () => const LoginPage()),
  ];
}
