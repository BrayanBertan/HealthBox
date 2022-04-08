import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/opinioes/row_paginacao.dart';
import 'package:healthbox/app/modules/opinioes/widgets/item_list_opiniao.dart';

class ListOpinioes extends StatelessWidget {
  const ListOpinioes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: 11,
          itemBuilder: (context, index) {
            return index == 10 ? RowPaginacao() : ItemListOpiniao();
          }),
    );
  }
}
