import 'package:flutter/material.dart';
import 'package:healthbox/app/modules/acompanhamentos/widgets/item_grid_acompanhamentos.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GridAcompanhamentos extends StatelessWidget {
  const GridAcompanhamentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = ResponsiveWrapper.of(context).screenHeight > 600;
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: screenHeight ? 200 : 150,
            mainAxisExtent: screenHeight ? 200 : 150,
            crossAxisSpacing: screenHeight ? 10 : 5,
            mainAxisSpacing: screenHeight ? 10 : 5,
            childAspectRatio: 1),
        itemCount: 15,
        itemBuilder: (context, index) {
          return ItemGridAcompanhamentos();
        });
  }
}
