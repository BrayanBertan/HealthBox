import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/questionarios_acompanhamento/widgets/item_list_questionarios.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ListQuestionarios extends StatelessWidget {
  const ListQuestionarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = ResponsiveWrapper.of(context).screenHeight > 600;
    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      child: Scrollbar(
        child: ListView.separated(
            physics: const ScrollPhysics(),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ItemListQuestionarios(
                index: index,
              );
            }),
      ),
    );
  }
}
