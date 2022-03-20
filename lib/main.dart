import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthbox/app/modules/login/binding.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'app/data/services/storage.dart';
import 'core/theme/app_theme.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const HealthBoxApp());
}

class HealthBoxApp extends StatelessWidget {
  const HealthBoxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthBox',
      theme: appThemeData,
      builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          minWidth: 480,
          defaultName: MOBILE,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.autoScale(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(700, name: TABLET),
            const ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ]),
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      initialBinding: LoginBinding(),
      initialRoute: Routes.INITIAL,
    );
  }
}
