import 'package:flutter/material.dart';

class RowPaginacao extends StatelessWidget {
  const RowPaginacao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: 50,
            child:
                ElevatedButton(onPressed: null, child: const Text('Anterior'))),
        Container(
            height: 50,
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Próximo'))),
      ],
    );
  }
}
