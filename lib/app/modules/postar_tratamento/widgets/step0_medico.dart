import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
import 'package:healthbox/app/modules/conta/dados_usuario/widgets/custom_text_rich.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/shimmer_select.dart';
import 'package:healthbox/app/modules/postar_tratamento/widgets/tile_dropdown_vinculo.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Step0MedicoTratamentoPage extends GetView<PostarTratamentoController> {
  const Step0MedicoTratamentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.carregandoVinculos
              ? const ShimmerSelects()
              : controller.vinculos.isEmpty
                  ? const Text('Sem vínculos disponiveis')
                  : DropdownSearch<Vinculo>(
                      mode: Mode.DIALOG,
                      dropdownSearchDecoration: const InputDecoration(
                        labelText: 'Selecionar o paciente',
                        isDense: true,
                      ),
                      onPopupDismissed: controller.setIsVinculoUntouched,
                      dropDownButton: Container(),
                      items: controller.vinculos,
                      dropdownButtonBuilder: null,
                      dropdownBuilder: (_, vinculo) => controller.vinculo ==
                              null
                          ? const Text('')
                          : TileDropDownVinculo(vinculo: controller.vinculo),
                      popupItemBuilder: (_, vinculo, __) =>
                          TileDropDownVinculo(vinculo: vinculo),
                      showSearchBox: true,
                      emptyBuilder: (_, __) => const Center(
                        child: Text(
                          'Nenhum vínculo foi encontrado.Use o campo de pesquisa acima.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      showClearButton: true,
                      onChanged: (Vinculo? vinculo) =>
                          controller.vinculo = vinculo,
                    ),
        ),
        Obx(() => Text(
              controller.vinculoErroMensagem ?? '',
              style: const TextStyle(color: Colors.red),
            )),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Ficha do paciente selecionado',
          style: subTitulo,
        ),
        const SizedBox(
          height: 15,
        ),
        Obx(
          () => controller.vinculo == null
              ? const Text('Nenhum paciente selecionado')
              : Column(
                  children: [
                    Obx(
                      () => controller.vinculo.fotoPath == null
                          ? Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        '${baseImagemUrl}user_pic.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: controller.vinculo.fotoPath,
                              imageBuilder: (context, imageProvider) => Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
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
                                    maxRadius: 30,
                                    minRadius: 30,
                                  ),
                                  baseColor: corPrincipal50,
                                  highlightColor: corPrincipal),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                    ),
                    Obx(() => CustomTextRich(
                        titulo: 'Nome: ', descricao: controller.vinculo.nome)),
                    Obx(() => CustomTextRich(
                        titulo: 'CPF: ',
                        descricao: controller.vinculo.paciente.cpf)),
                    Obx(() => CustomTextRich(
                        titulo: 'Telefone: ',
                        descricao: controller.vinculo.paciente.telefone)),
                    Obx(() => CustomTextRich(
                        titulo: 'Data de nascimento: ',
                        descricao: DateFormat('dd/MM/yyyy').format(
                            controller.vinculo.paciente.dataNascimento))),
                    Obx(() => CustomTextRich(
                        titulo: 'Idade: ',
                        descricao:
                            '${(DateTime.now().difference(controller.vinculo.paciente.dataNascimento).inDays / 365).round()}')),
                    Obx(() => CustomTextRich(
                        titulo: 'E-mail: ',
                        descricao: controller.vinculo.paciente.email)),
                    Obx(() => CustomTextRich(
                        titulo: 'Gênero: ',
                        descricao: controller.vinculo.paciente.genero ==
                                Genero.MASCULINO
                            ? 'Masculino'
                            : controller.vinculo.paciente.genero ==
                                    Genero.FEMININO
                                ? 'Feminino'
                                : 'Outro')),
                    Obx(() => CustomTextRich(
                        titulo: 'Altura: ',
                        descricao: '${controller.vinculo.paciente.altura}')),
                    Obx(() => CustomTextRich(
                        titulo: 'Peso: ',
                        descricao: '${controller.vinculo.paciente.peso}')),
                    Obx(() => CustomTextRich(
                        titulo: 'Comorbidades: ',
                        descricao:
                            controller.vinculo.paciente.comorbidades.isNotEmpty
                                ? controller.vinculo.paciente.comorbidades
                                : 'Nenhuma')),
                    Obx(() => CustomTextRich(
                        titulo: 'Alergias medicamentosas: ',
                        descricao: controller.vinculo.paciente
                                .alergiasMedicamentosas.isNotEmpty
                            ? controller.vinculo.paciente.alergiasMedicamentosas
                            : 'Nenhuma')),
                    Obx(() => CustomTextRich(
                        titulo: 'Predisposição genética: ',
                        descricao: controller.vinculo.paciente
                                .preDisposicaoGenetica.isNotEmpty
                            ? controller.vinculo.paciente.preDisposicaoGenetica
                            : 'Nenhuma')),
                  ],
                ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
