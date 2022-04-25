import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/tratamento.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';

import '../../data/repositories/tratamento.dart';

class AcompanhamentosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TratamentoProvider>(() => TratamentoProvider());
    Get.lazyPut<OpinioesController>(() => OpinioesController(
          repository:
              TratamentoRepository(provider: Get.find<TratamentoProvider>()),
        ));
  }
}
