import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthbox/core/theme/app_colors.dart';

void EasyLoadingConfig() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 5000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 60
    ..textColor = Colors.white
    ..radius = 20
    ..backgroundColor = corPrincipal
    ..maskColor = Colors.white
    ..indicatorColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[]
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid;
}
