import 'package:get/get.dart';
import 'package:healthbox/app/data/providers/tratamento.dart';
import 'package:healthbox/app/data/repositories/tratamento.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/controller_info_medicamento.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/controller_questoes.dart';

class PostarTratamentoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerInfoMedicamento>(() => ControllerInfoMedicamento());
    Get.lazyPut<ControllerQuestoes>(() => ControllerQuestoes());
    Get.lazyPut<TratamentoProvider>(() => TratamentoProvider());
    Get.lazyPut<PostarTratamentoController>(() => PostarTratamentoController(
        repository:
            TratamentoRepository(provider: Get.find<TratamentoProvider>())));
  }
}
