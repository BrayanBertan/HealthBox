import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class OpinioesController extends GetxController {
  OpinioesController() {
    final doc = Document()..insert(0, '');
    controller_editor = QuillController(
        onReplaceText: (int1, int2, obj) {
          texto = jsonEncode(controller_editor.document.toDelta().toJson());
          final doc = Document.fromJson(jsonDecode(texto));
          print(texto);
          if (texto.length >= 300) return false;
          return true;
        },
        document: doc,
        selection: const TextSelection.collapsed(offset: 0));
    final FocusNode _focusNode = FocusNode();
    quillEditor = QuillEditor(
      controller: controller_editor,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: _focusNode,
      autoFocus: false,
      readOnly: false,
      placeholder: 'Poste a sua opinião',
      expands: false,
      padding: const EdgeInsets.all(5),
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  final _texto = '[{"insert":"testeee\\n"}]'.obs;
  get texto => this._texto.value;
  set texto(value) => this._texto.value = value;

  QuillController controller_editor = QuillController.basic();
  late QuillEditor quillEditor;
}
