import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGraficosFiltro extends StatelessWidget {
  const ShimmerGraficosFiltro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Colors.black,
          ),
        ),
        baseColor: corPrincipal50,
        highlightColor: corPrincipal);
  }
}
