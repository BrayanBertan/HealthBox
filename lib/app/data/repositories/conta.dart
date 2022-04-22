import 'package:healthbox/app/data/providers/conta.dart';

import '../models/crm.dart';
import '../models/especializacao.dart';

class ContaRepository {
  final ContaProvider provider;

  ContaRepository({required this.provider}) : assert(provider != null);
  getEspecializacoes(List<Especializacao> itens) =>
      provider.getEspecializacoes(itens);
  deletaUsuario(int id) => provider.deletaUsuario(id);
  salvarCrm(Crm crm, int medicoId) => provider.salvarCrm(crm, medicoId);
  deletaCrm(int id) => provider.deletaCrm(id);
  salvarEspecializacao(int medicoCrmId, especializacaoId) =>
      provider.salvarEspecializacao(medicoCrmId, especializacaoId);
  deletaEspecializacao(int id) => provider.deletaEspecializacao(id);
  getUsuariosDisponiveis(String nome) => provider.getUsuariosDisponiveis(nome);
}
