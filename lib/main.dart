import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthbox/app/data/services/firebase_messaging_manager.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/core/theme/easy_loading_config.dart';
import 'package:healthbox/routes/app_pages.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'app/data/providers/usuario.dart';
import 'app/data/repositories/usuario.dart';
import 'app/data/services/storage.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());

  Get.lazyPut<UsuarioProvider>(() => UsuarioProvider());
  Get.put<LoginController>(
      LoginController(
          repository: UsuarioRepository(provider: Get.find<UsuarioProvider>())),
      permanent: true);
  final controller = Get.find<LoginController>();

  if (controller.verificaSessao()) {
    await Get.putAsync(() => FireBaseMessagingManager().init());

    controller.getSessaoToken();
    UsuarioProvider.token = Get.find<LoginController>().token;
    Get.find<LoginController>().getUsuario().then((val) {
      EasyLoadingConfig();
      runApp(const HealthBoxApp());
    });
  } else {
    EasyLoadingConfig();
    runApp(const HealthBoxApp());
  }
}

class HealthBoxApp extends StatelessWidget {
  const HealthBoxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthBox',
      theme: appThemeData,
      builder: EasyLoading.init(
          builder: (context, widget) => ResponsiveWrapper.builder(
                  ClampingScrollWrapper.builder(context, widget!),
                  minWidth: 480,
                  defaultName: MOBILE,
                  defaultScale: true,
                  breakpoints: [
                    const ResponsiveBreakpoint.autoScale(450, name: MOBILE),
                    const ResponsiveBreakpoint.autoScale(700, name: TABLET),
                    const ResponsiveBreakpoint.autoScale(800, name: DESKTOP),
                  ])),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt')],
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      // initialBinding: LoginBinding(),
      initialRoute: Routes.INITIAL,
    );
  }
}
