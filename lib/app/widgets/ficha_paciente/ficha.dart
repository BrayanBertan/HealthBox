import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthbox/app/data/enums/genero.dart';
import 'package:healthbox/app/data/models/paciente.dart';
import 'package:healthbox/app/widgets/custom_text_rich.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class FichaPaciente extends StatelessWidget {
  Paciente? paciente;
  FichaPaciente({required this.paciente, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: paciente == null
          ? const Text('Nenhum paciente selecionado')
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  paciente!.fotoPath == null
                      ? Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image:
                                    AssetImage('${baseImagemUrl}user_pic.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: paciente!.fotoPath!,
                          imageBuilder: (context, imageProvider) => Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.2,
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
                  CustomTextRich(titulo: 'Nome: ', descricao: paciente!.nome),
                  CustomTextRich(titulo: 'CPF: ', descricao: paciente!.cpf),
                  CustomTextRich(
                      titulo: 'Telefone: ', descricao: paciente!.telefone),
                  CustomTextRich(
                      titulo: 'Data de nascimento: ',
                      descricao: DateFormat('dd/MM/yyyy')
                          .format(paciente!.dataNascimento)),
                  CustomTextRich(
                      titulo: 'Idade: ',
                      descricao:
                          '${(DateTime.now().difference(paciente!.dataNascimento).inDays / 365).round()}'),
                  CustomTextRich(
                      titulo: 'E-mail: ', descricao: paciente!.email),
                  CustomTextRich(
                      titulo: 'Gênero: ',
                      descricao: paciente!.genero == Genero.MASCULINO
                          ? 'Masculino'
                          : paciente!.genero == Genero.FEMININO
                              ? 'Feminino'
                              : 'Outro'),
                  CustomTextRich(
                      titulo: 'Altura: ', descricao: '${paciente!.altura}'),
                  CustomTextRich(
                      titulo: 'Peso: ', descricao: '${paciente!.peso}'),
                  CustomTextRich(
                      titulo: 'Comorbidades: ',
                      descricao: paciente!.comorbidades.isNotEmpty
                          ? paciente!.comorbidades
                          : 'Nenhuma'),
                  CustomTextRich(
                      titulo: 'Alergias medicamentosas: ',
                      descricao: paciente!.alergiasMedicamentosas.isNotEmpty
                          ? paciente!.alergiasMedicamentosas
                          : 'Nenhuma'),
                  CustomTextRich(
                      titulo: 'Predisposição genética: ',
                      descricao: paciente!.preDisposicaoGenetica.isNotEmpty
                          ? paciente!.preDisposicaoGenetica
                          : 'Nenhuma'),
                ],
              ),
            ),
    );
  }
}
