import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/acompanhamento.dart';
import 'package:healthbox/app/data/models/medicamento_info.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/widgets/detalhes_tratamento/card_detalhes_interacoes.dart';
import 'package:healthbox/app/widgets/detalhes_tratamento/card_detalhes_medicamentos.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/values/keys.dart';

class DetalhesTratamentoPage extends StatelessWidget {
  OpinioesController? controller;
  LoginController loginController = Get.find<LoginController>();
  Acompanhamento? acompanhamento;
  String tituloPage = '';
  String tituloTratamento = '';
  String descricaoTratamento = '';
  String descricaoPaciente = '';
  String? foto;
  String nomeUsuario = '';
  String dataPostagem = '';
  String dataAtualizacao = '';
  var usuario;
  List<MedicamentoInfo> medicamentos = List<MedicamentoInfo>.empty();
  DetalhesTratamentoPage({Key? key}) : super(key: key) {
    acompanhamento = Get.arguments;
    usuario = loginController.getLogin();
    if (acompanhamento == null) {
      controller = Get.find<OpinioesController>();
      tituloPage = 'Detalhes da opinião';
      foto = controller!.opiniao.paciente?.fotoPath;
      nomeUsuario = controller!.opiniao.paciente?.nome ?? '';
      dataPostagem = controller!.opiniao?.dataPostagem ?? '';
      dataAtualizacao = controller!.opiniao?.dataAtualizacao ?? '';
      tituloTratamento = controller!.opiniao.tratamento!.titulo;
      descricaoTratamento = controller!.opiniao.descricao;
      medicamentos = controller!.opiniao.tratamento?.medicamentos ??
          List<MedicamentoInfo>.empty();
    } else {
      tituloPage = 'Detalhes do acompanhamento';
      descricaoPaciente = acompanhamento!.descricaoPaciente;
      foto = usuario.tipo == TipoUsuario.PACIENTE
          ? acompanhamento!.medico?.fotoPath
          : acompanhamento!.paciente?.fotoPath;
      nomeUsuario = usuario.tipo == TipoUsuario.PACIENTE
          ? acompanhamento!.medico?.nome ?? ''
          : acompanhamento!.paciente?.nome ?? '';
      dataAtualizacao = acompanhamento!.dataInicio ?? '';
      tituloTratamento = acompanhamento?.tratamento?.titulo ?? '';
      descricaoTratamento = acompanhamento?.tratamento?.descricao ?? '';
      medicamentos = acompanhamento?.tratamento?.medicamentos ??
          List<MedicamentoInfo>.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloPage),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (foto == null)
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('${baseImagemUrl}user_pic.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            else
              CachedNetworkImage(
                imageUrl: foto!,
                imageBuilder: (context, imageProvider) => Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                    child: const CircleAvatar(
                      maxRadius: 45,
                      minRadius: 45,
                    ),
                    baseColor: corPrincipal50,
                    highlightColor: corPrincipal),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            acompanhamento == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Postado em $dataPostagem',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Atualizado em $dataAtualizacao',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Text(
                    'Tratamento inicia em $dataAtualizacao',
                    textAlign: TextAlign.center,
                  ),
            Text(
              nomeUsuario,
              style: subTitulo,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              tituloTratamento,
              style: titulo,
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Expanded(
                    child: Card(
                  child: QuillEditor(
                    controller: QuillController(
                        document:
                            Document.fromJson(jsonDecode(descricaoTratamento)),
                        selection: const TextSelection.collapsed(offset: 0)),
                    scrollController: ScrollController(),
                    scrollable: true,
                    focusNode: FocusNode(),
                    minHeight: MediaQuery.of(context).size.height * 0.3,
                    maxHeight: MediaQuery.of(context).size.height * 0.3,
                    autoFocus: false,
                    readOnly: true,
                    enableInteractiveSelection: false,
                    expands: false,
                    padding: const EdgeInsets.all(5),
                  ),
                )),
                acompanhamento == null
                    ? Container(
                        padding: const EdgeInsets.all(1),
                        width: 30,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            color: controller!.opiniao.eficaz == 1
                                ? Colors.green
                                : Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular((5)))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: controller!
                              .getEficacia(controller!.opiniao.eficaz)
                              .map((texto) => texto)
                              .toList(),
                        ))
                    : Container()
              ],
            ),
            Text(
              acompanhamento == null
                  ? 'Descrição do tratamento'
                  : usuario.tipo == TipoUsuario.PACIENTE
                      ? ''
                      : 'Descrição paciente',
              style: subTitulo,
            ),
            acompanhamento == null
                ? Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Text(
                        controller!.opiniao.tratamento.descricao,
                      ),
                    ),
                  )
                : usuario.tipo == TipoUsuario.PACIENTE
                    ? Container()
                    : Card(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Text(
                            descricaoPaciente,
                          ),
                        ),
                      ),
            CardDetalhesMedicamentos(medicamentos: medicamentos),
            acompanhamento == null
                ? CardDetalhesInteracoes(opiniao: controller!.opiniao)
                : Container(),
          ],
        ),
      ),
    );
  }
}
