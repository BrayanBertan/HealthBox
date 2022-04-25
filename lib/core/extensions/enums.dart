import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/enums/periodicidade_medicamento.dart';
import 'package:healthbox/app/data/enums/tipo_questao.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/enums/unidade_medida.dart';

extension StringExtension on String? {
  TipoUsuario tipoUsuario() {
    switch (this) {
      case 'PACIENTE':
        return TipoUsuario.PACIENTE;
      case 'P':
        return TipoUsuario.PACIENTE;
      case 'MEDICO':
        return TipoUsuario.MEDICO;
      case 'M':
        return TipoUsuario.MEDICO;
      default:
        return TipoUsuario.PACIENTE;
    }
  }

  Genero genero() {
    switch (this) {
      case 'MASCULINO':
        return Genero.MASCULINO;
      case 'M':
        return Genero.MASCULINO;
      case 'FEMININO':
        return Genero.FEMININO;
      case 'F':
        return Genero.FEMININO;
      default:
        return Genero.OUTROS;
    }
  }

  UnidadeMedida unidadeMedida() {
    switch (this) {
      case 'MG':
        return UnidadeMedida.MG;
      case 'G':
        return UnidadeMedida.G;
      case 'ML':
        return UnidadeMedida.ML;
      case 'GO':
        return UnidadeMedida.GO;
      default:
        return UnidadeMedida.MGO;
    }
  }

  PeriodicidadeMedicamento periodicidadeMedicamento() {
    switch (this) {
      case 'horas':
        return PeriodicidadeMedicamento.horas;
      case 'M':
        return PeriodicidadeMedicamento.dias;
      default:
        return PeriodicidadeMedicamento.horas;
    }
  }

  TipoQuestao tipoQuestao() {
    switch (this) {
      case 'horas':
        return TipoQuestao.DESCRITIVA;
      case 'M':
        return TipoQuestao.MULTIPLA_ESCOLHA;
      default:
        return TipoQuestao.DESCRITIVA;
    }
  }
}
