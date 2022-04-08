import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/card_detalhes_interacoes.dart';
import 'package:healthbox/app/modules/opinioes/widgets/detalhes_opiniao/card_detalhes_medicamentos.dart';
import 'package:healthbox/app/modules/opinioes/widgets/info_item_list_opiniao.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../../../../core/values/keys.dart';

class PageDetalhesOpiniao extends StatelessWidget {
  PageDetalhesOpiniao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 100.0,
              child: Image.asset('${baseImagemUrl}user_pic.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Nomeeeeee',
              style: titulo,
              textAlign: TextAlign.center,
            ),
            Card(
              child: InfoItemListOpiniao(index: Get.arguments),
            ),
            CardDetalhesMedicamentos(),
            CardDetalhesInteracoes(),
          ],
        ),
      ),
    );
  }
}
