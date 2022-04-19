import 'package:healthbox/app/data/providers/grafico.dart';

class GraficoRepository {
  final GraficoProvider provider;
  GraficoRepository({required this.provider}) : assert(provider != null);

  getGraficos({required String medicamentos}) =>
      provider.getGraficos(medicamentos: medicamentos);
}
