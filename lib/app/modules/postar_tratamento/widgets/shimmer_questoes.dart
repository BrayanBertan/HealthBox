import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerQuestoes extends StatelessWidget {
  const ShimmerQuestoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      physics: const ScrollPhysics(),
      itemBuilder: (_, index) => Shimmer.fromColors(
          child: Container(
            margin: const EdgeInsets.all(5),
            height: 50,
            color: Colors.black,
          ),
          baseColor: corPrincipal50,
          highlightColor: corPrincipal),
    );
  }
}
