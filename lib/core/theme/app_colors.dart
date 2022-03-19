import 'package:flutter/material.dart';

final corBase = "447b76";
final corPrincipal = retornaHex(0xFF);
final corPrincipal900 = retornaHex(0xE6);
final corPrincipal800 = retornaHex(0xCC);
final corPrincipal700 = retornaHex(0xB3);
final corPrincipal600 = retornaHex(0x99);
final corPrincipal500 = retornaHex(0x80);
final corPrincipal400 = retornaHex(0x66);
final corPrincipal300 = retornaHex(0x4D);
final corPrincipal200 = retornaHex(0x33);
final corPrincipal100 = retornaHex(0x1A);
final corPrincipal50 = retornaHex(0x0D);

Color corSecundaria = const Color(0xffFFFFFF);
Color corPrincipalTexto = const Color(0xffFFFFFF);
Color corSecundariaTexto = const Color(0xff000000);

Color retornaHex(int opacidade) =>
    Color(int.parse("$opacidade$corBase", radix: 16));
