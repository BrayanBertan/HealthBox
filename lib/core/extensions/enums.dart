import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';

extension TipoUsuarioExtensionString on String {
  TipoUsuario get nome {
    switch (this) {
      case 'PACIENTE':
        return TipoUsuario.PACIENTE;
      case 'MEDICO':
        return TipoUsuario.MEDICO;
      default:
        return TipoUsuario.PACIENTE;
    }
  }
}

extension GeneroExtensionString on String {
  Genero get nome {
    switch (this) {
      case 'MASCULINO':
        return Genero.MASCULINO;
      case 'FEMININO':
        return Genero.FEMININO;
      default:
        return Genero.OUTROS;
    }
  }
}
