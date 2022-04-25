import 'package:get/get.dart';
import 'package:healthbox/app/data/repositories/tratamento.dart';
import 'package:healthbox/app/modules/login/controller.dart';

class AcompanhamentosController extends GetxController {
  final TratamentoRepository repository;

  final loginController = Get.find<LoginController>();

  AcompanhamentosController({required this.repository})
      : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    usuario = loginController.getLogin();
  }

  final _usuario = Rx<dynamic>(null);

  get usuario => this._usuario.value;
  set usuario(value) => this._usuario.value = value;
}
