import 'package:healthbox/app/data/providers/grafico.dart';

class GraficoRepository {
  final GraficoProvider provider;
  GraficoRepository({required this.provider}) : assert(provider != null);

  getGraficos({required String endpoint}) =>
      provider.getGraficos(endpoint: endpoint);

  getGraficosMedico(String remedios, int tipo) =>
      provider.getGraficosMedico(remedios, tipo);

  getMedicamentosUsadosFiltro(String endpoint) =>
      provider.getMedicamentosUsadosFiltro(endpoint);

  getGraficosResposta(int idPaciente) =>
      provider.getGraficosResposta(idPaciente);
}
