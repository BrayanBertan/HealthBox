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
      'valor': "&data"
    },
    {
      "titulo": "Data de publicação: da mais antiga a mais nova",
      'valor': "&data1"
    },
    {"titulo": "Likes: com mais likes", 'valor': "&order_likes=desc"},
    {"titulo": "Dislikes: com mais dislikes", 'valor': "&order_dislikes=desc"},
  ];

  final _orderBy = '&order_likes=desc'.obs;
  final _eficaz = '&eficaz'.obs;

  get orderBy => _orderBy.value;
  setOrderBy(value) => _orderBy.value = value;
  get eficaz => _eficaz.value;
  setEficaz(value) => _eficaz.value = value;
  Medicamento medicamento =
      Medicamento(id: 0, nome: 'Todos', bula: '', fabricante: '');
  setMedicamento(value) =>
      value == null || value.id == 0 ? null : medicamento = value;
  setController() {
    print('xddddd');
    Get.find<OpinioesController>().filtros = clone();
    Get.back();
  }

  FiltroOpinioesController clone() {
    final controllerTemp = FiltroOpinioesController();

    controllerTemp.setOrderBy(orderBy);
    controllerTemp.setEficaz(eficaz);
    controllerTemp.setMedicamento(medicamento);

    return controllerTemp;
  }

  @override
  String toString() {
    return ' $orderBy  $eficaz  ${medicamento.nome}';
  }
}
