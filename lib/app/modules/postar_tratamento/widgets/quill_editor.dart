import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';

class QuillEditorColumn extends GetView<PostarTratamentoController> {
  QuillEditorColumn({Key? key}) : super(key: key) {
    controller.controller_editor = QuillController(
        onReplaceText: (int1, int2, obj) {
          if (controller.texto == null) controller.texto = '';
          int tamanho =
              controller.controller_editor.document.toPlainText().length;
          controller.controller_editor.document.toDelta();
          if ((int1 == 0 && int2 == 1) || tamanho >= 200) return false;
          return true;
        },
        document: controller.doc,
        selection: const TextSelection.collapsed(offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          controller.isPaciente ? 'Sua opinião' : 'Descrição do tratamento',
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: QuillToolbar.basic(
              controller: controller.controller_editor,
              showAlignmentButtons: true,
              showImageButton: false,
              showVideoButton: false,
              showCameraButton: false,
              showColorButton: false,
              showUndo: false,
              showRedo: false,
              showBackgroundColorButton: false,
              showStrikeThrough: false,
              showClearFormat: false,
              locale: const Locale('pt'),
              toolbarIconAlignment: WrapAlignment.start,
            )),
        Container(
          margin: const EdgeInsets.only(top: 25),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Obx(() => controller.carregando
              ? const Text('carregando...')
              : QuillEditor(
                  onTapDown: (_, __) {
                    controller.tituloFocus.unfocus();
                    return false;
                  },
                  controller: controller.controller_editor,
                  scrollController: ScrollController(),
                  scrollable: true,
                  focusNode: FocusNode(),
                  autoFocus: false,
                  readOnly: false,
                  placeholder: controller.texto,
                  expands: true,
                  padding: const EdgeInsets.all(5),
                )),
        ),
      ],
    );
  }
}
