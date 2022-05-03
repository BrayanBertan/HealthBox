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

  get carregando => this._carregando.value;
  set carregando(value) => this._carregando.value = value;
  get tipoVisualizacao => this._tipoVisualizacao.value;
  set tipoVisualizacao(value) => this._tipoVisualizacao.value = value;
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

  changeVisualizacao(int tipoVisuazalicaoParam) {
    tipoVisualizacao = tipoVisuazalicaoParam;
    if (tipoVisuazalicaoParam == 1) getUsuariosAcompanhamentos();
    if (tipoVisuazalicaoParam == 2) getQuestionarios();
  }

  //==========================Acompanhamentos===========================================
  final _usuarioSelecionado = Rx<Usuario?>(null);
  List<Acompanhamento> acompanhamentos = <Acompanhamento>[].obs;
  get usuarioSelecionado => this._usuarioSelecionado.value;
  set usuarioSelecionado(value) => this._usuarioSelecionado.value = value;

  getAcompanhamentos(int index) {
    carregando = true;
    usuarioSelecionado = usuariosAcompanhamentos[index];
    repository.getAcompanhamentos(usuarioSelecionado.id).then((retorno) {
      acompanhamentos.assignAll(retorno);
      print('$acompanhamentos');
      carregando = false;
    });
  }

//==========================Questionários===========================================

  List<Rx<dynamic>> camposRespostas = <Rx<dynamic>>[].obs;
  Map<DateTime, List<Questionario>> questionarios =
      <DateTime, List<Questionario>>{}.obs;
  List<Questionario> questionariosSelecionados = <Questionario>[].obs;
  final _calendarFormat = CalendarFormat.twoWeeks.obs;
  final _diaSelecionado = DateTime.now().obs;

  get calendarFormat => this._calendarFormat.value;
  setCalendarFormat(value) => this._calendarFormat.value = value;
  get diaSelecionado => this._diaSelecionado.value;
  set diaSelecionado(value) => this._diaSelecionado.value = value;

  setQuestionariosDia(DateTime diaSelecionadoParam) {
    diaSelecionado = DateTime(diaSelecionadoParam.year,
        diaSelecionadoParam.month, diaSelecionadoParam.day);
    questionariosSelecionados
        .assignAll(questionarios[diaSelecionado] ?? <Questionario>[]);
  }

  getQuestionarios({int? idAcompanhamento}) {
    carregando = true;
    repository
        .getQuestionarios(idAcompanhamento: idAcompanhamento)
        .then((retorno) {
      if (idAcompanhamento != null) {
        questionariosSelecionados.assignAll(retorno);
        carregando = false;
        return;
      }
      questionarios = {};
      retorno.forEach((questionario) {
        DateTime dataIndex = DateTime(questionario.dataResposta!.year,
            questionario.dataResposta!.month, questionario.dataResposta!.day);
        List<Questionario> original =
            questionarios[dataIndex] ?? List<Questionario>.empty();

        if (original.isEmpty) {
          questionarios[dataIndex] = [questionario];
        } else {
          questionarios[dataIndex]!.add(questionario);
        }
      });
      DateTime selecionado = DateTime(
          diaSelecionado.year, diaSelecionado.month, diaSelecionado.day);

      questionariosSelecionados
          .assignAll(questionarios[selecionado] ?? List<Questionario>.empty());

      carregando = false;
    });
  }

  setCamposRespostas(List<Questao> questoes) {
    camposRespostas.clear();
    questoes.asMap().forEach((index, questao) {
      print('baaa xd ${questao.resposta?.opcaoId}');
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
    if (diferenca > 0) return {'disponivel': 2, 'legenda': 'Futuro'};
    if (diferenca < 0) return {'disponivel': 0, 'legenda': 'Finalizado'};
    return {'disponivel': 1, 'legenda': 'Aberto'};
  }

  String? isCampoValido(index) {
    dynamic valor = camposRespostas[index].value;
    if (valor == null || valor.length > 2) return null;
    return 'Respota muito curta';
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
      } else {
        EasyLoading.showToast(
            'Erro ao responder questionário, tente novamente mais tarde',
            duration: const Duration(milliseconds: 500),
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    });
  }
}
