import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/periodicidade_medicamento.dart';
import 'package:healthbox/app/data/enums/unidade_medida.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';

class ControllerInfoMedicamento extends GetxController {
  final _dose = Rx<String?>(null);
  get dose => this._dose.value;
  setDose(value) => this._dose.value = value;

  late Medicamento medicamento;
  final _unidade = UnidadeMedida.MG.obs;
  get unidade => this._unidade.value;
  set unidade(value) => this._unidade.value = value;

  final _periodicidade = PeriodicidadeMedicamento.horas.obs;
  get periodicidade => this._periodicidade.value;
  set periodicidade(value) => this._periodicidade.value = value;

  final _intervalo = Rx<String?>(null);
  get intervalo => this._intervalo.value;
  setIntervalo(value) => this._intervalo.value = value;

  final _duracao = Rx<String?>(null);
  get duracao => this._duracao.value;
  setDuracao(value) => this._duracao.value = value;

  bool doseValida() => dose != null && dose.isNotEmpty;

  bool intervaloValido() => intervalo != null && intervalo.isNotEmpty;

  bool duracaoValida() => duracao != null && duracao.isNotEmpty;

  String? get mensagemErro {
    String? retorno;
    if ((dose == null || doseValida()) &&
        (intervalo == null || intervaloValido()) &&
        (duracao == null || duracaoValida())) {
      return null;
    }
    retorno = 'Campos obrigatórios  ';
    if (!doseValida()) retorno += ' dose';
    if (!intervaloValido()) retorno += ' intervalo';
    if (!duracaoValida()) retorno += ' duração';

    return retorno;
  }

  bool formValido() => doseValida() && intervaloValido() && duracaoValida();

  clearFields() {
    setDuracao(null);
    setIntervalo(null);
    setDose(null);
    periodicidade = PeriodicidadeMedicamento.horas;
    unidade = UnidadeMedida.MG;
  }

  salvarInfo() {
    MedicamentoInfo medicamentoInfo = MedicamentoInfo(
        dose: dose,
        unidadeMedida: unidade,
        duracao: duracao,
        intervalo: intervalo,
        periodicidadeMedicamento: periodicidade,
        medicamento: medicamento);
    final controller = Get.find<PostarTratamentoController>();
    int index = controller.medicamentosSelecionadosInfo.indexWhere(
        (medicamentoParam) =>
            medicamentoParam.medicamento.isEqual(medicamento));

    controller.medicamentosSelecionadosInfo[index] = medicamentoInfo;

    clearFields();
    Get.back();
  }
}
