import 'package:healthbox/app/data/models/opiniao.dart';
import 'package:healthbox/app/data/providers/tratamento.dart';

class TratamentoRepository {
  final TratamentoProvider provider;
  TratamentoRepository({required this.provider}) : assert(provider != null);

  getOpinioes() => provider.getOpinioes();
  salvarOpiniao(Opiniao opiniao) => provider.salvarOpiniao(opiniao);
}
