import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/modules/postar_tratamento/controller.dart';

import '../../../../../core/theme/app_colors.dart';

class PagePostarTratamento extends GetView<PostarTratamentoController> {
  PagePostarTratamento({Key? key}) : super(key: key);
  final controller_opinioes = Get.find<OpinioesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal100,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: QuillToolbar.basic(
                    controller: controller_opinioes.controller_editor,
                    showAlignmentButtons: true,
                  )),
              const SizedBox(
                height: 25,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.2,
                child: controller_opinioes.quillEditor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
