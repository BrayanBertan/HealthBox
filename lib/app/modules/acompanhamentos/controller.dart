import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/acompanhamento.dart';
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

  //==========================Todos===========================================
  final _carregando = false.obs;
  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;
  //==========================Usuarios Acompanhamentos===========================================
  final _usuario = Rx<dynamic>(null);

  List<Usuario> usuariosAcompanhamentos = <Usuario>[].obs;

  get usuario => this._usuario.value;
  set usuario(value) => this._usuario.value = value;

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

  //==========================Acompanhamentos===========================================
  final _usuarioSelecionado = Rx<Usuario?>(null);
  get usuarioSelecionado => this._usuarioSelecionado.value;
  set usuarioSelecionado(value) => this._usuarioSelecionado.value = value;
  List<Acompanhamento> acompanhamentos = <Acompanhamento>[].obs;
  getAcompanhamentos(int index) {
    carregando = true;
    usuarioSelecionado = usuariosAcompanhamentos[index];
    repository.getAcompanhamentos(usuarioSelecionado.id).then((retorno) {
      acompanhamentos.assignAll(retorno);
      print('$acompanhamentos');
      carregando = false;
    });
  }
}
