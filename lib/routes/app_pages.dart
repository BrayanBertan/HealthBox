import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/binding.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/view.dart';
import 'package:healthbox/app/modules/home/binding.dart';
import 'package:healthbox/app/modules/home/view.dart';
import 'package:healthbox/app/modules/login/view.dart';
import 'package:healthbox/routes/middlewares/autentica_usuario.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.INITIAL,
        page: () => HomePage(),
        binding: HomeBinding(),
        middlewares: [AutenticaUsuario()]),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(), /* middlewares: [SetTokenUsuario()]*/
    ),
    GetPage(
        name: Routes.DADOS_USUARIO,
        page: () => DadosUsuarioPage(),
        binding: DadosUsuarioBinding()),
  ];
}
