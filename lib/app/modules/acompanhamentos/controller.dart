import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/data/models/usuario.dart';
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
    getUsuariosAcompanhamentos();
  }

  final _usuario = Rx<dynamic>(null);
  final _carregando = false.obs;
  List<Usuario> usuariosAcompanhamentos = <Usuario>[].obs;

  get usuario => this._usuario.value;
  set usuario(value) => this._usuario.value = value;

  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;

  getUsuariosAcompanhamentos() {
    carregando = true;
    var func = repository.getUsuariosAcompanhamentos<Paciente>();
    if (usuario.tipo == TipoUsuario.PACIENTE) {
      func = repository.getUsuariosAcompanhamentos<Medico>();
    }
    func.then((retorno) {
      usuariosAcompanhamentos.assignAll(retorno);
      carregando = false;
    });
  }
}
