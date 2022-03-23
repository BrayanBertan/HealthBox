import 'package:flutter/material.dart';

class CustomTextRich extends StatelessWidget {
  String? titulo;
  String? descricao;
  CustomTextRich({this.titulo = '', this.descricao = '', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '${descricao}    '),
      ]),
    );
  }
}
