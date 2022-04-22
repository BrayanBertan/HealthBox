import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVinculos extends StatelessWidget {
  const ShimmerVinculos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (_, index) => Shimmer.fromColors(
            child: Row(
              children: [
                CircleAvatar(
                    child: Image.asset('${baseImagemUrl}user_pic.png'),
                    minRadius: 20,
                    maxRadius: 20),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 50,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            baseColor: corPrincipal50,
            highlightColor: corPrincipal),
      ),
    );
  }
}
