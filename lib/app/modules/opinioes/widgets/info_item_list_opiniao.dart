import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';

class InfoItemListOpiniao extends GetView<OpinioesController> {
  const InfoItemListOpiniao({Key? key}) : super(key: key);

  get result => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eros justo, viverra quis nunc eget, laoreet volutpat nulla.',
            maxLines: false ? 10 : 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          IgnorePointer(
            ignoring: true,
            child: Obx(
              () => QuillEditor(
                controller: QuillController(
                    document: Document.fromJson(jsonDecode(controller.texto)),
                    selection: const TextSelection.collapsed(offset: 0)),
                scrollController: ScrollController(),
                scrollable: false,
                focusNode: FocusNode(),
                autoFocus: false,
                readOnly: true,
                expands: false,
                padding: const EdgeInsets.all(5),
              ),
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
