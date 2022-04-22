import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOpinioes extends StatelessWidget {
  const ShimmerOpinioes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (_, __) => Shimmer.fromColors(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    margin: const EdgeInsets.only(left: 25.0),
                    padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Stack(
                        children: const [
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: -2,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('${baseImagemUrl}user_pic.png'),
                      radius: 20,
                    ),
                  ),
                ],
              ),
              baseColor: corPrincipal50,
              highlightColor: corPrincipal)),
    );
  }
}
