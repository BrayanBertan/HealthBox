import 'package:get/get.dart';
import 'package:healthbox/app/data/models/medicamento.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';

class FiltroOpinioesController extends GetxController {
  FiltroOpinioesController();
  @override
  void onInit() {
    super.onInit();
  }

  final orderByList = <Map<String, dynamic>>[
    {
      "titulo": "Data de publicação: da mais nova a mais antiga",
      'valor': "&order_data=desc"
    },
    {
      "titulo": "Data de publicação: da mais antiga a mais nova",
      'valor': "&order_data=asc"
    },
    {"titulo": "Likes: com mais likes", 'valor': "&order_likes=desc"},
    {"titulo": "Dislikes: com mais dislikes", 'valor': "&order_dislikes=desc"},
  ];

  final _orderBy = '&order_likes=desc'.obs;
  final _eficaz = '&eficaz'.obs;

  final medicamentosSelecionados = <Medicamento>[
    Medicamento(id: 0, nome: 'Todos', bula: '', fabricante: '')
  ].obs;
  String medicamentosId = '';
  get orderBy => _orderBy.value;
  setOrderBy(value) => _orderBy.value = value;
  get eficaz => _eficaz.value;
  setEficaz(value) => _eficaz.value = value;
  Medicamento medicamento =
      Medicamento(id: 0, nome: 'Todos', bula: '', fabricante: '');

  setMedicamento(value) {
    bool todos = medicamentosSelecionados.first.id == 0;
    int id = medicamentosSelecionados.first.id!;
    bool isNotTodos = value.id != 0;
    if (isNotTodos && todos) deleteMedicamento(0);
    if (!isNotTodos) {
      medicamentosSelecionados.clear();
      medicamentosSelecionados.add(medicamento);
    }
    if (id != value.id) medicamentosSelecionados.add(value);
  }

  setController() {
    Get.find<OpinioesController>().filtros = clone();
    Get.back();
  }

  deleteMedicamento(int index) {
    Medicamento medicamentoSelecionado = medicamentosSelecionados[index];

    medicamentosSelecionados.remove(medicamentoSelecionado);

    if (medicamentoSelecionado.id != 0 && medicamentosSelecionados.isEmpty)
      medicamentosSelecionados.add(medicamento);
  }

  FiltroOpinioesController clone() {
    final controllerTemp = FiltroOpinioesController();

    controllerTemp.setOrderBy(orderBy);
    controllerTemp.setEficaz(eficaz);
    controllerTemp.medicamentosSelecionados.assignAll(medicamentosSelecionados);

    return controllerTemp;
  }

  @override
  String toString() {
    return ' $orderBy  $eficaz  ${medicamentosId}';
  }
}
