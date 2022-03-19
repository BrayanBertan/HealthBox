import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
