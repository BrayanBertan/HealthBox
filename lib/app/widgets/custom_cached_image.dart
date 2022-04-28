import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedImage extends StatelessWidget {
  String? foto;
  double width, height;
  CustomCachedImage(
      {this.foto, required this.width, required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return foto == null
        ? Image.asset(
            '${baseImagemUrl}user_pic.png',
            fit: BoxFit.fill,
            width: width,
            height: height,
          )
        : CachedNetworkImage(
            imageUrl: foto!,
            imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
                child: Image.asset(
                  '${baseImagemUrl}user_pic.png',
                  fit: BoxFit.fill,
                  width: width,
                  height: height,
                ),
                baseColor: corPrincipal50,
                highlightColor: corPrincipal),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
  }
}
