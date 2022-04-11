import 'package:get/get.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/modules/login/controller.dart';

import '../../data/repositories/tratamento.dart';

class OpinioesController extends GetxController {
  final TratamentoRepository repository;
  final loginController = Get.find<LoginController>();

  OpinioesController({required this.repository}) : assert(repository != null);

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => usuario = loginController.getLogin());
    super.onInit();
    getOpinioes();
    ever(_page, (val) => getOpinioes());
  }

  final _usuario = Rx<dynamic>(null);
  final _opiniao = Rx<Opiniao?>(null);
  final _carregando = false.obs;
  final opinioes = <Opiniao>[].obs;
  final _page = 1.obs;
  final _isMinhasOpinoesChecked = false.obs;
  final _isGerenciarMinhasOpinioesOpen = true.obs;
  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;
  get usuario => this._usuario.value;
  set usuario(value) => this._usuario.value = value;
  get isGerenciarMinhasOpinioesOpen =>
      this._isGerenciarMinhasOpinioesOpen.value;
  set isGerenciarMinhasOpinioesOpen(value) =>
      this._isGerenciarMinhasOpinioesOpen.value = value;

  get opiniao => this._opiniao.value;
  set opiniao(value) => this._opiniao.value = value;

  get isMinhasOpinoesChecked => this._isMinhasOpinoesChecked.value;
  setIsMinhasOpinoesChecked() =>
      this._isMinhasOpinoesChecked.value = !isMinhasOpinoesChecked;

  get page => this._page.value;

  setPageAnterior() => this._page.value--;
  setPageProxima() => this._page.value++;

  getOpinioes() {
    carregando = true;
    int? pacienteId = null;
    if (isMinhasOpinoesChecked) {
      pacienteId = usuario.id;
    }
    repository.getOpinioes(pacienteId: pacienteId, page: page).then((retorno) {
      opinioes.clear();
      opinioes.assignAll(retorno);
      carregando = false;
    });
  }
}
