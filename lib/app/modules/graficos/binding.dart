import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/grafico.dart';
import 'package:healthbox/app/data/repositories/grafico.dart';

import 'controller.dart';

class GraficosOpinioesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GraficoProvider>(() => GraficoProvider());

    Get.lazyPut<GraficosOpinioesController>(() => GraficosOpinioesController(
          repository: GraficoRepository(provider: Get.find<GraficoProvider>()),
        ));
  }
}
