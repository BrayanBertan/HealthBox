import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/providers/tratamento.dart';

class TratamentoRepository {
  final TratamentoProvider provider;
  TratamentoRepository({required this.provider}) : assert(provider != null);

  getOpinioes({int? pacienteId, int page = 1}) =>
      provider.getOpinioes(pacienteId: pacienteId, page: page);
  salvarOpiniao(Opiniao opiniao) => provider.salvarOpiniao(opiniao);
  deletarOpiniao(int id) => provider.deletarOpiniao(id);

  setLike(bool isLike, opiniaoId) => provider.setLike(isLike, opiniaoId);
  deleteLike(int opiniaoId) => provider.deleteLike(opiniaoId);

  getMedicamentosFiltro(String filtro) =>
      provider.getMedicamentosFiltro(filtro);
}
