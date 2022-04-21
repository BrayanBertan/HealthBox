import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';

class InfoItemListOpiniao extends GetView<OpinioesController> {
  int index;
  InfoItemListOpiniao({required this.index, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            controller.opinioes[index].tratamento?.titulo ?? '',
            maxLines: false ? 10 : 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            Document.fromJson(jsonDecode(controller.opinioes[index].descricao))
                .toPlainText(),
            maxLines: 1,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
