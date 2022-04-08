import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../opinioes/controller.dart';

class QuillEditorColumn extends StatelessWidget {
  QuillEditorColumn({Key? key}) : super(key: key);
  final controller_opinioes = Get.find<OpinioesController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: QuillToolbar.basic(
              controller: controller_opinioes.controller_editor,
              showAlignmentButtons: true,
            )),
        Container(
          margin: const EdgeInsets.only(top: 55),
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.3,
          child: controller_opinioes.quillEditor,
        ),
      ],
    );
  }
}
