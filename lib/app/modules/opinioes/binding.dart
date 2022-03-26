import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';

class OpinioesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OpinioesController());
  }
}
