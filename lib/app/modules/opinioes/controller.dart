import 'package:get/get.dart';
import 'package:healthbox/app/data/models/opiniao.dart';

import '../../data/repositories/tratamento.dart';

class OpinioesController extends GetxController {
  final TratamentoRepository repository;
  dynamic usuario;

  OpinioesController({required this.repository}) : assert(repository != null) {}

  @override
  void onInit() {
    super.onInit();
    getOpinioes();
    ever(_page, (val) => getOpinioes());
  }

  final _opiniao = Rx<Opiniao?>(null);
  final _carregando = false.obs;
  final opinioes = <Opiniao>[].obs;
  final _page = 1.obs;
  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;

  get opiniao => this._opiniao.value;
  set opiniao(value) => this._opiniao.value = value;

  get page => this._page.value;

  setPageAnterior() => this._page.value--;
  setPageProxima() => this._page.value++;

  getOpinioes() {
    carregando = true;
    repository.getOpinioes(page: page).then((retorno) {
      opinioes.clear();
      opinioes.assignAll(retorno);
      carregando = false;
    });
  }
}
