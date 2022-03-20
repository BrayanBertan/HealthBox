import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('${controller.verificaSessao('brayanbertan@gmail.com')}'),
      ),
    );
  }
}
