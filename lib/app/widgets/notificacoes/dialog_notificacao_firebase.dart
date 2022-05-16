import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthbox/app/data/models/notificacao.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:shimmer/shimmer.dart';

class DialogNotificacaoFirebase extends StatelessWidget {
  Notificacao notificacao;
  dynamic usuario;
  DialogNotificacaoFirebase({required this.notificacao, Key? key})
      : super(key: key) {
    if (notificacao.medico == null) {
      usuario = notificacao.paciente;
    } else {
      usuario = notificacao.medico;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              notificacao.titulo,
              style: titulo,
              textAlign: TextAlign.center,
            ),
            Text(
              notificacao.descricao,
              style: subTitulo,
              textAlign: TextAlign.center,
            ),
            ListTile(
              leading: usuario?.fotoPath == null
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
                      imageUrl: usuario!.fotoPath!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
              title: Text('Remetente ${usuario?.nome ?? ''}'),
            ),
          ],
        ),
      ),
    );
  }
}
