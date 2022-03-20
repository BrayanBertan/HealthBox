import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/view.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.INITIAL, page: () => const LoginPage()),
  ];
}
