import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/opinioes/widgets/item_list_opiniao.dart';

class ListOpinioes extends StatelessWidget {
  const ListOpinioes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) {
          return ItemListOpiniao();
        });
  }
}
