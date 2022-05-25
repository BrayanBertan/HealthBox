import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
import 'package:healthbox/app/modules/conta/controller.dart';
import 'package:healthbox/app/widgets/ficha_paciente/dialog_ficha.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:shimmer/shimmer.dart';

class ItemListaVinculos extends GetView<ContaController> {
  int index;
  List<Vinculo> lista;
  List<IconButton> trailing;
  ItemListaVinculos(
      {required this.lista,
      required this.index,
      required this.trailing,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.usuario.tipo == TipoUsuario.PACIENTE ||
              lista[index].paciente == null
          ? null
          : showDialog(
              context: context,
              builder: (_) =>
                  DialogFichaPaciente(paciente: lista[index].paciente)),
      child: ListTile(
        leading: lista[index].fotoPath == null
            ? Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  image: DecorationImage(
                    image: AssetImage('${baseImagemUrl}user_pic.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: lista[index].fotoPath!,
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                    child: const CircleAvatar(
                      maxRadius: 20,
                      minRadius: 20,
                    ),
                    baseColor: corPrincipal50,
                    highlightColor: corPrincipal),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
        title: Text(
          lista[index].nome,
          textAlign: TextAlign.center,
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: trailing.map<IconButton>((botao) => botao).toList(),
        ),
      ),
    );
  }
}
