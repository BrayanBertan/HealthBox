import 'package:healthbox/app/data/providers/conta.dart';

import '../models/crm.dart';

class ContaRepository {
  final ContaProvider provider;

  ContaRepository({required this.provider}) : assert(provider != null);
  getEspecializacoes() => provider.getEspecializacoes();
  deletaUsuario(int id) => provider.deletaUsuario(id);
  salvarCrm(Crm crm, int medicoId) => provider.salvarCrm(crm, medicoId);
  deletaCrm(int id) => provider.deletaCrm(id);
}
