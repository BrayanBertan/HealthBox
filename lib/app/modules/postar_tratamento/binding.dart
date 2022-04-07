import 'package:get/get.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';

class PostarTratamentoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostarTratamentoController());
  }
}
