import 'package:healthbox/app/data/models/acompanhamento.dart';
import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/models/questao.dart';
import 'package:healthbox/app/data/models/questionario.dart';
import 'package:healthbox/app/data/models/tratamento.dart';
import 'package:healthbox/app/data/providers/tratamento.dart';
import 'package:healthbox/app/modules/opinioes/widgets/sub_controllers/controller_filtro_opinoes.dart';

class TratamentoRepository {
  final TratamentoProvider provider;
  TratamentoRepository({required this.provider}) : assert(provider != null);

  //=================================Acompanhamentos=====================================
  getUsuariosAcompanhamentos<T>() => provider.getUsuariosAcompanhamentos<T>();
  salvarAcompanhamento(Acompanhamento acompanhamento) =>
      provider.salvarAcompanhamento(acompanhamento);
  salvarQuestionario(Questionario questionario) =>
      provider.salvarQuestionario(questionario);

  deletarAcompanhamento(int id) => provider.deletarAcompanhamento(id);

  getAcompanhamentos(int id) => provider.getAcompanhamentos(id);
//=================================Quesitonários=====================================
  salvarRespostas(Map<String, dynamic> respostas) =>
      provider.salvarRespostas(respostas);
  getQuestionarios({int? idAcompanhamento}) =>
      provider.getQuestionarios(idAcompanhamento: idAcompanhamento);
  //=================================Questões=====================================
  salvarQuestao(Questao questao) => provider.salvarQuestao(questao);

  deletarQuestao(int id) => provider.deletarQuestao(id);

  deletarOpcao(int id) => provider.deletarOpcao(id);

  salvarIntermediaria(Map<String, List<Map<String, dynamic>>> vinculos) =>
      provider.salvarIntermediaria(vinculos);

  getQuestoesPreCadastradas() => provider.getQuestoesPreCadastradas();

  //=================================Opiniões=====================================
  getOpinioes(
          {int? pacienteId,
          int page = 1,
          required FiltroOpinioesController filtros,
          required String search}) =>
      provider.getOpinioes(
          pacienteId: pacienteId, page: page, filtros: filtros, search: search);
  salvarOpiniao(Opiniao opiniao) => provider.salvarOpiniao(opiniao);
  deletarOpiniao(int id) => provider.deletarOpiniao(id);

  setLike(bool isLike, opiniaoId) => provider.setLike(isLike, opiniaoId);
  deleteLike(int likeId) => provider.deleteLike(likeId);

  getMedicamentosFiltro(String filtro) =>
      provider.getMedicamentosFiltro(filtro);

  salvarTratamento(Tratamento tratamento) =>
      provider.salvarTratamento(tratamento);
}
