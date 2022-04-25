import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ItemListQuestionarios extends StatelessWidget {
  int index;
  ItemListQuestionarios({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
      ),
      title: AutoSizeText(
        'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        maxLines: 2,
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.list),
      ),
    );
  }
}
