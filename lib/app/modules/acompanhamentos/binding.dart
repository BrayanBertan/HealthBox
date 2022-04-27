import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/tratamento.dart';
import 'package:healthbox/app/modules/acompanhamentos/controller.dart';

import '../../data/repositories/tratamento.dart';

class AcompanhamentosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TratamentoProvider>(() => TratamentoProvider());
    Get.lazyPut<AcompanhamentosController>(() => AcompanhamentosController(
          repository:
              TratamentoRepository(provider: Get.find<TratamentoProvider>()),
        ));
  }
}
