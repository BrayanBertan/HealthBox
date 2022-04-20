import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/models/like.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/app/modules/opinioes/widgets/sub_controllers/controller_filtro_opinoes.dart';

import '../../data/models/medicamento.dart';
import '../../data/repositories/tratamento.dart';

class OpinioesController extends GetxController {
  final TratamentoRepository repository;

  final loginController = Get.find<LoginController>();

  OpinioesController({required this.repository}) : assert(repository != null);

  @override
  void onInit() {
    super.onInit();
    usuario = loginController.getLogin();
    getOpinioes();
    ever(_page, (val) => getOpinioes());
    everAll([_filtros, _search], (val) {
      if (page == 1)
        getOpinioes();
      else
        _page.value = 1;
    });
  }

  Future<List<Medicamento>> getMedicamentos(String? filtro) async {
    final medicamento =
        Medicamento(id: 0, nome: 'Todos', bula: '', fabricante: '');
    if (filtro == null) {
      return <Medicamento>[
        ...[medicamento],
        ...List<Medicamento>.empty()
      ];
    }
    final medicamentos = await repository.getMedicamentosFiltro(filtro);

    return <Medicamento>[
      ...[medicamento],
      ...medicamentos
    ];
  }

  final _usuario = Rx<dynamic>(null);
  final _opiniao = Rx<Opiniao?>(null);
  final _carregando = false.obs;
  final _carregandoTela = false.obs;
  final opinioes = <Opiniao>[].obs;
  final _page = 1.obs;
  final _isMinhasOpinoesChecked = false.obs;
  final _isGerenciarMinhasOpinioesOpen = true.obs;
  final _filtros = FiltroOpinioesController().obs;
  final searchController = TextEditingController();
  final _search = ''.obs;

  get search => this._search.value;
  setSearch() => this._search.value = searchController.text;

  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;

  get filtros => this._filtros.value;
  set filtros(value) => this._filtros.value = value;

  get carregandoTela => this._carregandoTela.value;
  set carregandoTela(value) => this._carregandoTela.value = value;

  get usuario => this._usuario.value;
  set usuario(value) => this._usuario.value = value;
  get isGerenciarMinhasOpinioesOpen =>
      this._isGerenciarMinhasOpinioesOpen.value;
  set isGerenciarMinhasOpinioesOpen(value) =>
      this._isGerenciarMinhasOpinioesOpen.value = value;

  get opiniao => this._opiniao.value;
  set opiniao(value) => this._opiniao.value = value;

  get isMinhasOpinoesChecked => this._isMinhasOpinoesChecked.value;
  setIsMinhasOpinoesChecked() {
    this._isMinhasOpinoesChecked.value = !isMinhasOpinoesChecked;
    if (page == 1) {
      getOpinioes();
      return;
    }
    _page.value = 1;
  }

  get page => this._page.value;

  setPageAnterior() => this._page.value--;
  setPageProxima() => this._page.value++;

  getOpinioes() {
    print('entrou');
    carregando = true;
    int? pacienteId = null;
    if (isMinhasOpinoesChecked) {
      pacienteId = usuario.id;
    }
    setMedicamentosId();
    repository
        .getOpinioes(
            pacienteId: pacienteId,
            page: page,
            filtros: filtros,
            search: search.isEmpty ? '&titulo' : '&titulo=$search')
        .then((retorno) {
      opinioes.clear();
      opinioes.assignAll(retorno);
      carregando = false;
    });
  }

  setMedicamentosId() {
    filtros.medicamentosId = '';
    filtros.medicamentosSelecionados
        .forEach((element) => filtros.medicamentosId += '${element.id},');
    filtros.medicamentosId =
        filtros.medicamentosId.substring(0, filtros.medicamentosId.length - 1);
  }

  final listaLikesAtualizada = <Like>[].obs;
  setLike(bool isLike, int opiniaoId, List<Like> likes) =>
      repository.setLike(isLike, opiniaoId).then((retorno) {
        if (retorno is bool) {
          EasyLoading.showToast('Erro ao salvar like',
              toastPosition: EasyLoadingToastPosition.bottom);
          listaLikesAtualizada.clear();
        } else {
          print('deu bom 1');
          int indexLike =
              likes.indexWhere((element) => element.idUsuario == usuario.id);
          if (likes.isEmpty || indexLike < 0) {
            likes.add(retorno);
          } else {
            likes[indexLike] = retorno;
          }
          listaLikesAtualizada.clear();
          listaLikesAtualizada.assignAll(likes);
        }
      });

  isLiked(List<Like> likes, int isLike) {
    //checar
    if (usuario == null) return false;
    return likes
        .where((like) => like.idUsuario == usuario.id && like.isLike == isLike)
        .isNotEmpty;
  }

  deleteLike(List<Like> likes) {
    if (usuario == null) return false;
    int id = likes.where((element) => element.idUsuario == usuario.id).first.id;

    repository.deleteLike(id).then((retorno) {
      if (retorno) {
        print('deu bom 2');
      } else {
        EasyLoading.showToast('Erro ao deletar  like',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }

  List<Text> getEficacia(int tipo) {
    TextStyle textStyle = const TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15);
    List<Text> textos = [
      Text('f', style: textStyle),
      Text('i', style: textStyle),
      Text('c', style: textStyle),
      Text('a', style: textStyle),
      Text('z', style: textStyle)
    ];
    return tipo == 1
        ? [
            ...[
              Text('E', style: textStyle),
            ],
            ...textos
          ]
        : [
            ...[
              Text('I', style: textStyle),
              Text('n', style: textStyle),
              Text('e', style: textStyle)
            ],
            ...textos
          ];
  }

  inicializaLikes(List<Like> likes) {
    if (usuario != null) {
      final listaFiltrada =
          likes.where(((like) => like.idUsuario == usuario.id));
      final tamanho = listaFiltrada.length;
      if (tamanho > 0) {
        return listaFiltrada.first.isLike;
      } else {
        return 2;
      }
    }
  }

  // atualizaLikesLocalmente(int index, isLike) {
  //   if (opinioes[index].likes == null) {
  //     opinioes[index].likes = List<Like>.empty();
  //     opinioes[index].likes!.add(Like(
  //         id: 0,
  //         idOpiniao: opinioes[index].id!,
  //         idUsuario: usuario.id,
  //         isLike: isLike));
  //   }
  //   int indexLike = opinioes[index]
  //       .likes!
  //       .indexWhere((element) => element.idUsuario == usuario.id);
  //   if (indexLike < 0) {
  //     opinioes[index].likes!.add(Like(
  //         id: 0,
  //         idOpiniao: opinioes[index].id!,
  //         idUsuario: usuario.id,
  //         isLike: isLike));
  //   } else {
  //     opinioes[index].likes![indexLike] = Like(
  //         id: 0,
  //         idOpiniao: opinioes[index].id!,
  //         idUsuario: usuario.id,
  //         isLike: isLike);
  //   }
  //}

  // Stream<String> testee(int n) async* {
  //   for (var i = 1; i <= 30; i++) {
  //     await Future.delayed(Duration(seconds: 1));
  //     yield 'aa $i';
  //   }
  // }
}
