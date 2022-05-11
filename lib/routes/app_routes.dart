part of 'app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const DETALHES_TRATAMENTO = '/detalhes-opiniao';
  static const POSTAR_TRATAMENTO = '/postar-tratamento';
  static const LOGIN = '/login';
  static const CONTA = '/conta';
  static const DADOS_USUARIO = '/conta/usuario';
  static const GRAFICOS_OPINIOES = '/graficos-opinioes';
  static const GRAFICO_BARRA = '/graficos-opinioes/barra';
  static const GRAFICO_PIE = '/graficos-opinioes/pie';
  static const GRAFICO_BARRA_EFICACIA = '/graficos-opinioes/barra-eficacia';
  static const GRAFICO_LINES = '/graficos-opinioes/lines';
  static const GRAFICO_MELHORA = '/graficos-acompanhamento/melhora';
  static const ACOMPANHAMENTOS = '/acompanhamentos';
  static const LISTAGEM_ACOMPANHAMENTOS = '/acompanhamentos/listagem';
  static const QUESTIONARIO_ACOMPANHAMENTOS = '/acompanhamentos/questionario';
}
