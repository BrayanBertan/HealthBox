import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/opinioes/widgets/info_item_list_opiniao.dart';
import 'package:healthbox/app/modules/opinioes/widgets/interacoes_item_list_opiniao.dart';

import '../../../../core/values/keys.dart';

class ItemListOpiniao extends StatelessWidget {
  int index;
  ItemListOpiniao({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 1,
          margin: const EdgeInsets.only(left: 25.0),
          padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
          child: Card(
            margin: const EdgeInsets.only(bottom: 25),
            child: Stack(
              children: [
                InfoItemListOpiniao(index: index),
                InteracoesItemListOpiniao(index: index)
              ],
            ),
          ),
        ),
        Positioned(
            left: -2,
            child: Row(
              children: [
                CircleAvatar(
                  child: Image.asset('${baseImagemUrl}user_pic.png'),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text('Nomeeeee')
              ],
            )),
      ],
    );
  }
}
