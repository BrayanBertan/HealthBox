import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class StepLines extends StatelessWidget {
  String texto;
  StepLines({required this.texto, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: corPrincipal,
        )),
        Container(
          alignment: Alignment.center,
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: corPrincipal,
          ),
          child: Text(texto),
        ),
        Expanded(
            child: Divider(
          color: corPrincipal,
        ))
      ],
    );
  }
}
