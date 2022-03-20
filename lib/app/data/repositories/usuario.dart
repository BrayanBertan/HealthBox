import 'package:healthbox/app/data/providers/usuario.dart';

class UsuarioRepository {
  final UsuarioProvider usuarioProvider;

  UsuarioRepository({required this.usuarioProvider})
      : assert(usuarioProvider != null);

  verificaLogin(String email, String senha) =>
      usuarioProvider.verificaLogin(email, senha);
}
