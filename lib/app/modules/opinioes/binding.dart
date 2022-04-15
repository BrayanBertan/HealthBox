import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/tratamento.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/sub_controllers/controller_interacoes.dart';

import '../../data/repositories/tratamento.dart';

class OpinioesBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<InteracaoController>(() => InteracaoController());
    Get.lazyPut<TratamentoProvider>(() => TratamentoProvider());
    Get.lazyPut<OpinioesController>(() => OpinioesController(
        repository:
            TratamentoRepository(provider: Get.find<TratamentoProvider>())));
  }
}
