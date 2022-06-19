import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_questao.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/acompanhamento.dart';
import 'package:healthbox/app/data/models/medico.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/app/data/models/questionario.dart';
import 'package:healthbox/app/data/models/usuario.dart';
import 'package:healthbox/app/data/repositories/tratamento.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:table_calendar/table_calendar.dart';

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
  final _tipoVisualizacao = 1.obs;
  final _carregandoInfoAcompanhamento = false.obs;
  final _pesquisa = ''.obs;
  final _delaypesquisarUsuariosAcompanhmentos = false.obs;

  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;
  get tipoVisualizacao => this._tipoVisualizacao.value;
  set tipoVisualizacao(value) => this._tipoVisualizacao.value = value;
  get carregandoInfoAcompanhamento => this._carregandoInfoAcompanhamento.value;
  set carregandoInfoAcompanhamento(value) =>
      this._carregandoInfoAcompanhamento.value = value;
  get pesquisa => this._pesquisa.value;
  setPesquisa(value) => this._pesquisa.value = value;
  //==========================Usuarios Acompanhamentos===========================================
  final _usuario = Rx<dynamic>(null);
  bool delayVinculos = false;
  bool delayDatas = false;

  List<Usuario> usuariosAcompanhamentos = <Usuario>[].obs;

  get usuario => this._usuario.value;
  set usuario(value) => this._usuario.value = value;

  get delaypesquisarUsuariosAcompanhmentos =>
      this._delaypesquisarUsuariosAcompanhmentos.value;
  set delaypesquisarUsuariosAcompanhmentos(value) =>
      this._delaypesquisarUsuariosAcompanhmentos.value = value;

  getUsuariosAcompanhamentos() {
    carregando = true;
    var func = repository.getUsuariosAcompanhamentos<Paciente>(pesquisa);
    if (usuario.tipo == TipoUsuario.PACIENTE) {
      func = repository.getUsuariosAcompanhamentos<Medico>(pesquisa);
    }
    func.then((retorno) {
      usuariosAcompanhamentos.assignAll(retorno);
      orderByUsuario();
      carregando = false;
      if (loginController.redictToAcompanhamentos) {
        getAcompanhamentos(usuariosAcompanhamentos.indexWhere(
            (element) => element.id == loginController.idRemetente));
      }
    });
  }

  pesquisarUsuariosAcompanhmentos() {
    if (!delaypesquisarUsuariosAcompanhmentos) {
      getUsuariosAcompanhamentos();
      delaypesquisarUsuariosAcompanhmentos = true;
      Timer(const Duration(seconds: 3),
          () => delaypesquisarUsuariosAcompanhmentos = false);
    }
  }

  changeVisualizacao(int tipoVisuazalicaoParam) {
    tipoVisualizacao = tipoVisuazalicaoParam;
    if (tipoVisuazalicaoParam == 1) {
      if (!delayVinculos) {
        getUsuariosAcompanhamentos();
        delayVinculos = true;
        Timer(const Duration(seconds: 15), () => delayVinculos = false);
      }
    }
    if (tipoVisuazalicaoParam == 2) {
      if (!delayDatas) {
        getQuestionarios();
        delayDatas = true;
        Timer(const Duration(seconds: 15), () => delayDatas = false);
      }
    }
  }

  //==========================Acompanhamentos===========================================
  final _usuarioSelecionado = Rx<Usuario?>(null);
  final _orderByPendenteVar = 1.obs;
  final _orderByUsuarioVar = 1.obs;

  List<Acompanhamento> acompanhamentos = <Acompanhamento>[].obs;
  get usuarioSelecionado => this._usuarioSelecionado.value;
  set usuarioSelecionado(value) => this._usuarioSelecionado.value = value;
  get orderByPendenteVar => this._orderByPendenteVar.value;
  set orderByPendenteVar(value) => this._orderByPendenteVar.value = value;
  get orderByUsuarioVar => this._orderByUsuarioVar.value;
  set orderByUsuarioVar(value) => this._orderByUsuarioVar.value = value;

  getAcompanhamentos(int index) {
    carregando = true;
    usuarioSelecionado = usuariosAcompanhamentos[index];
    repository.getAcompanhamentos(id: usuarioSelecionado.id).then((retorno) {
      acompanhamentos.assignAll(retorno);
      orderByPendente();
      carregando = false;
      if (loginController.redictToAcompanhamentos) {
        loginController.redictToAcompanhamentos = false;
        Get.toNamed(Routes.LISTAGEM_ACOMPANHAMENTOS);
      }
    });
  }

  orderByPendente() {
    acompanhamentos.sort((a, b) {
      int aPendente = a.respostaPendente! ? 1 : 0;
      int bPendente = b.respostaPendente! ? 1 : 0;
      if (orderByPendenteVar == 1) return aPendente > bPendente ? 1 : 0;
      return aPendente < bPendente ? 1 : 0;
    });
    if (orderByPendenteVar == 1) {
      orderByPendenteVar = 2;
    } else {
      orderByPendenteVar = 1;
    }
  }

  orderByUsuario() {
    usuariosAcompanhamentos.sort((a, b) => orderByUsuarioVar == 1
        ? a.nome.compareTo(b.nome)
        : b.nome.compareTo(a.nome));

    if (orderByUsuarioVar == 1) {
      orderByUsuarioVar = 2;
    } else {
      orderByUsuarioVar = 1;
    }
  }

//==========================Questionários===========================================

  List<Rx<dynamic>> camposRespostas = <Rx<dynamic>>[].obs;
  Map<DateTime, List<Questionario>> questionarios =
      <DateTime, List<Questionario>>{}.obs;
  List<Questionario> questionariosSelecionados = <Questionario>[].obs;
  List<Questionario> questionariosVisualizacao = <Questionario>[].obs;
  final _calendarFormat = CalendarFormat.twoWeeks.obs;
  final _diaSelecionado = DateTime.now().obs;

  get calendarFormat => this._calendarFormat.value;
  setCalendarFormat(value) => this._calendarFormat.value = value;
  get diaSelecionado => this._diaSelecionado.value;
  set diaSelecionado(value) => this._diaSelecionado.value = value;

  setQuestionariosDia(DateTime diaSelecionadoParam) {
    carregando = true;
    diaSelecionado = DateTime(diaSelecionadoParam.year,
        diaSelecionadoParam.month, diaSelecionadoParam.day);
    questionariosSelecionados
        .assignAll(questionarios[diaSelecionado] ?? <Questionario>[]);
    carregando = false;
  }

  getQuestionarios({int? idAcompanhamento}) {
    carregando = true;
    repository
        .getQuestionarios(idAcompanhamento: idAcompanhamento)
        .then((retorno) {
      if (idAcompanhamento != null) {
        questionariosVisualizacao.assignAll(retorno);
        carregando = false;
        return;
      }
      questionarios = {};
      retorno.forEach((questionarioParam) {
        DateTime dataIndex = DateTime(
            questionarioParam.dataResposta!.year,
            questionarioParam.dataResposta!.month,
            questionarioParam.dataResposta!.day);
        List<Questionario> original =
            questionarios[dataIndex] ?? List<Questionario>.empty();

        if (original.isEmpty) {
          questionarios[dataIndex] = [questionarioParam];
        } else {
          questionarios[dataIndex]!.add(questionarioParam);
        }
      });
      DateTime selecionado = DateTime(
          diaSelecionado.year, diaSelecionado.month, diaSelecionado.day);

      questionariosSelecionados
          .assignAll(questionarios[selecionado] ?? List<Questionario>.empty());

      carregando = false;
    });
  }

  getInfoAcompanhamento(int idAcompanhamento) =>
      repository.getInfoAcompanhamento(idAcompanhamento).then((retorno) {
        if (retorno is bool) {
          EasyLoading.showToast('Erro ao buscar info do acompanhamento',
              duration: const Duration(milliseconds: 500),
              toastPosition: EasyLoadingToastPosition.bottom);
          return null;
        } else {
          return retorno;
        }
      });

  setCamposRespostas(List<Questao> questoes) {
    camposRespostas.clear();
    questoes.asMap().forEach((index, questao) {
      return questao.tipo == TipoQuestao.O
          ? camposRespostas.add(Rx<dynamic>(questao.resposta?.opcaoId == null
              ? questao.opcoes![0].id
              : questao.resposta!.opcaoId))
          : camposRespostas
              .add(Rx<dynamic>(questao.resposta?.respostaDescritiva));
    });
  }

  Map<String, dynamic> getHistoricoLegenda(DateTime date) {
    DateTime hoje = DateTime.now();
    hoje = DateTime(hoje.year, hoje.month, hoje.day);
    int diferenca = date.difference(hoje).inDays;
    if (diferenca > 0) return {'disponivel': 2, 'legenda': ' Futuro'};
    if (diferenca < 0) return {'disponivel': 0, 'legenda': ' Finalizado'};
    return {'disponivel': 1, 'legenda': ' Aberto'};
  }

  Map<String, dynamic> isQuestionarioRespondido(List<Questao>? questoesParam) {
    if (questoesParam == null || questoesParam.isEmpty) {
      return {'isRespondido': '', 'cor': Colors.black};
    }
    int count = 0;
    questoesParam.forEach((questaoParam) {
      if (questaoParam.resposta != null) count++;
    });

    if (questoesParam.length == count) {
      return {'isRespondido': ' | Respondido', 'cor': Colors.green};
    }
    return {'isRespondido': ' | Não respondido', 'cor': Colors.red};
  }

  Widget getStepContainer(Questionario questionario) {
    int disponivel =
        getHistoricoLegenda(questionario.dataResposta!)['disponivel'];
    String isRespondido =
        isQuestionarioRespondido(questionario.questoes)['isRespondido'];
    Color cor = Colors.red;
    if (disponivel == 1) {
      cor = Colors.yellow;
    } else if (isRespondido == ' | Respondido' && disponivel == 0) {
      cor = Colors.green;
    } else if (questionario.dataResposta!.difference(DateTime.now()).inHours >
        0) {
      cor = Colors.grey;
    }

    return Container(
      color: cor,
    );
  }

  String? isCampoValido(index) {
    dynamic valor = camposRespostas[index].value;
    if (valor == null || valor.length > 2) return null;
    return 'Resposta muito curta';
  }

  bool isFormValido() =>
      camposRespostas.where((resposta) => resposta.value == null).isEmpty;

  salvarQuestionario(int idQuestionario, List<Questao> questoes) {
    if (questoes.isEmpty) return;
    Map<String, dynamic> dados = {
      'questionario_id': idQuestionario,
      'respostas': []
    };
    camposRespostas.asMap().forEach((index, resposta) {
      Questao questao = questoes[index];
      bool isDescritiva = questao.tipo == TipoQuestao.D;
      dados['respostas'].add({
        'opcao_id': isDescritiva ? null : resposta.value,
        'questionario_questao_id': questao.idIndermediaria,
        'resposta_descritiva': !isDescritiva ? null : resposta.value,
      });
    });
    repository.salvarRespostas(dados).then((retorno) {
      if (retorno) {
        EasyLoading.showToast('Questionário respondido com sucesso',
            duration: const Duration(milliseconds: 500),
            toastPosition: EasyLoadingToastPosition.bottom);
        if (Get.previousRoute == '/acompanhamentos/listagem') {
          int index = getIndexUsuarioSelecionado();
          getAcompanhamentos(index);
        } else {
          getQuestionarios();
        }
      } else {
        EasyLoading.showToast(
            'Erro ao responder questionário, tente novamente mais tarde',
            duration: const Duration(milliseconds: 500),
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      Get.back();
    });
  }

  getIndexUsuarioSelecionado() => usuariosAcompanhamentos
      .indexWhere((usuario) => usuario.id == usuarioSelecionado?.id);
}
