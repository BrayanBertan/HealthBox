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
  salvarUsuario(Map<String, dynamic> usuario) =>
      provider.salvarUsuario(usuario);
  validaCRM(String crm, String uf) => provider.validaCRM(crm, uf);
  verificaEmail(String email) => provider.verificaEmail(email);
  getEspecializacoes() => provider.getEspecializacoes();
}
