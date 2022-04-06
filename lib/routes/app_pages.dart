import 'package:get/get.dart';
import 'package:healthbox/app/modules/conta/binding.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/binding.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/view.dart';
import 'package:healthbox/app/modules/conta/view.dart';
import 'package:healthbox/app/modules/login/view.dart';
import 'package:healthbox/app/modules/opinioes/binding.dart';
import 'package:healthbox/app/modules/opinioes/view.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/page_detalhes_opiniao.dart';
import 'package:healthbox/routes/middlewares/autentica_usuario.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.INITIAL,
        page: () => OpinioesPage(),
        binding: OpinioesBinding(),
        middlewares: [AutenticaUsuario()]),
    GetPage(
      name: Routes.DETALHES_OPINIAO,
      page: () => PageDetalhesOpiniao(), /* middlewares: [SetTokenUsuario()]*/
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(), /* middlewares: [SetTokenUsuario()]*/
    ),
    GetPage(
        name: Routes.CONTA,
        page: () => ContaPage(),
        bindings: [ContaBinding()],
        middlewares: [AutenticaUsuario()]),
    GetPage(
        name: Routes.DADOS_USUARIO,
        page: () => DadosUsuarioPage(),
        binding: DadosUsuarioBinding()),
  ];
}
