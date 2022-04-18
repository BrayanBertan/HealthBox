import 'package:get/get.dart';

import 'controller.dart';

class GraficosOpinioesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GraficosOpinioesController>(
      () => GraficosOpinioesController(),
    );
  }
}
