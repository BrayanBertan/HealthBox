import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class GraficosOpinioesView extends GetView<GraficosOpinioesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GraficosOpinioesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GraficosOpinioesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
