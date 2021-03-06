import 'package:healthbox/app/data/models/notificacao.dart';
import 'package:healthbox/app/data/providers/usuario.dart';

class UsuarioRepository {
  final UsuarioProvider provider;

  UsuarioRepository({required this.provider}) : assert(provider != null);

  verificaLogin(String email, String senha) =>
      provider.verificaLogin(email, senha);

  criaSessao(String token, int duracaoSessao) =>
      provider.criaSessao(token, duracaoSessao);

  verificaSessao() => provider.verificaSessao();

  getUsuario() => provider.getUsuario();
  getSessaoToken() => provider.getSessaoToken();
  salvarUsuario<T>(var usuario) => provider.salvarUsuario<T>(usuario);
  validaCRM(String crm, String uf) => provider.validaCRM(crm, uf);
  verificaDadosRepetidos(
          {String email = '',
          crm = '',
          cpf = '',
          uf = '',
          tipoPesquisa = ''}) =>
      provider.verificaDadosRepetidos(
          email: email, cpf: cpf, crm: crm, uf: uf, tipoPesquisa: tipoPesquisa);
  getEspecializacoes() => provider.getEspecializacoes();
  logout() => provider.logout();
  enviarNotificacao(Notificacao notificacao) =>
      provider.enviarNotificacao(notificacao);
}
