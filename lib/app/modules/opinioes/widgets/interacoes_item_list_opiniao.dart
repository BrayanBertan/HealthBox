import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/values/keys.dart';

class InteracoesItemListOpiniao extends StatelessWidget {
  const InteracoesItemListOpiniao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          height: 40,
          color: corPrincipal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset('${baseImagemUrl}gostar.png', width: 25),
                  const SizedBox(
                    width: 2,
                  ),
                  Text('10'),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Image.asset('${baseImagemUrl}dislike.png', width: 25)
                    ],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text('5')
                ],
              ),
              Row(
                children: [
                  Image.asset('${baseImagemUrl}comments.png', width: 25),
                  const SizedBox(
                    width: 2,
                  ),
                  Text('10')
                ],
              ),
            ],
          ),
        ));
  }
}
