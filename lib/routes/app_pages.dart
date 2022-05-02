import 'package:get/get.dart';
import 'package:healthbox/app/modules/acompanhamentos/binding.dart';
import 'package:healthbox/app/modules/acompanhamentos/view.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/view.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/acompanhamentos/widgets/questionarios/view.dart';
import 'package:healthbox/app/modules/graficos/widgets/grafico_barra_eficacia.dart';
import 'package:healthbox/app/modules/graficos/widgets/grafico_barra_horizontal.dart';
import 'package:healthbox/app/modules/graficos/widgets/grafico_lines.dart';
import 'package:healthbox/app/modules/graficos/widgets/grafico_pie.dart';
import 'package:healthbox/app/widgets/detalhes_tratamento/page_detalhes_tratamento.dart';

import '../app/modules/conta/binding.dart';
import '../app/modules/conta/dados_usuario/binding.dart';
import '../app/modules/conta/dados_usuario/view.dart';
import '../app/modules/conta/view.dart';
import '../app/modules/graficos/binding.dart';
import '../app/modules/graficos/view.dart';
import '../app/modules/login/view.dart';
import '../app/modules/opinioes/binding.dart';
import '../app/modules/opinioes/view.dart';
import '../app/modules/postar_tratamento/binding.dart';
import '../app/modules/postar_tratamento/view.dart';
import 'middlewares/autentica_usuario.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.INITIAL,
        page: () => OpinioesPage(),
        binding: OpinioesBinding(),
        middlewares: [AutenticaUsuario()]),
    GetPage(
      name: Routes.DETALHES_TRATAMENTO,
      page: () => DetalhesTratamentoPage(),
    ),
    GetPage(
        name: Routes.POSTAR_TRATAMENTO,
        page: () => PagePostarTratamento(),
        binding: PostarTratamentoBinding()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.CONTA,
      page: () => ContaPage(),
      bindings: [ContaBinding()],
    ),
    GetPage(
        name: Routes.DADOS_USUARIO,
        page: () => DadosUsuarioPage(),
        binding: DadosUsuarioBinding()),
    GetPage(
      name: Routes.GRAFICOS_OPINIOES,
      page: () => GraficosOpinioesPage(),
      binding: GraficosOpinioesBinding(),
    ),
    GetPage(
      name: Routes.GRAFICO_BARRA,
      page: () => GraficoBarraHorizontalPage(),
    ),
    GetPage(
      name: Routes.GRAFICO_PIE,
      page: () => GraficoPiePage(),
    ),
    GetPage(
      name: Routes.GRAFICO_BARRA_EFICACIA,
      page: () => GraficoBarraEficaciaPage(),
    ),
    GetPage(
      name: Routes.GRAFICO_LINES,
      page: () => GraficoLinesPage(),
    ),
    GetPage(
        name: Routes.ACOMPANHAMENTOS,
        page: () => AcompanhamentoPage(),
        binding: AcompanhamentosBinding()),
    GetPage(
      name: Routes.LISTAGEM_ACOMPANHAMENTOS,
      page: () => ListagemAcompanhamentoPage(),
    ),
    GetPage(
      name: Routes.QUESTIONARIO_ACOMPANHAMENTOS,
      page: () => QuestionarioPage(),
    ),
  ];
}
