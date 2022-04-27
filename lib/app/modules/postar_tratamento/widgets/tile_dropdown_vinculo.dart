import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthbox/app/data/models/vinculo.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:shimmer/shimmer.dart';

class TileDropDownVinculo extends StatelessWidget {
  Vinculo vinculo;
  TileDropDownVinculo({required this.vinculo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: vinculo.fotoPath == null
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
              imageUrl: vinculo.fotoPath!,
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
        vinculo.nome,
        textAlign: TextAlign.center,
      ),
    );
  }
}
