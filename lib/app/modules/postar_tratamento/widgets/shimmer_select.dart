import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSelects extends StatelessWidget {
  const ShimmerSelects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          margin: const EdgeInsets.all(5),
          height: 50,
          color: Colors.black,
        ),
        baseColor: corPrincipal50,
        highlightColor: corPrincipal);
  }
}
