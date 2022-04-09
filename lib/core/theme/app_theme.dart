import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';

final appThemeData = ThemeData(
    primarySwatch: MaterialColor(corPrincipal.value, {
      50: Color(corPrincipal50.value),
      100: Color(corPrincipal100.value),
      200: Color(corPrincipal200.value),
      300: Color(corPrincipal300.value),
      400: Color(corPrincipal400.value),
      500: Color(corPrincipal500.value),
      600: Color(corPrincipal600.value),
      700: Color(corPrincipal700.value),
      800: Color(corPrincipal800.value),
      900: Color(corPrincipal900.value),
    }),
    primaryColor: corPrincipal500,
    fontFamily: 'sourcesanspro',
    backgroundColor: corPrincipal100,
    textTheme: Typography().englishLike);
