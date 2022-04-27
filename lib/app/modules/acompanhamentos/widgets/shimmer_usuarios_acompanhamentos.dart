import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUsuariosAcompanhamentos extends StatelessWidget {
  bool tamanho;
  ShimmerUsuariosAcompanhamentos({required this.tamanho, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: tamanho ? 200 : 150,
            mainAxisExtent: tamanho ? 200 : 150,
            crossAxisSpacing: tamanho ? 10 : 5,
            mainAxisSpacing: tamanho ? 10 : 5,
            childAspectRatio: 1),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
              child: Container(
                color: Colors.black,
              ),
              baseColor: corPrincipal50,
              highlightColor: corPrincipal);
        });
  }
}
