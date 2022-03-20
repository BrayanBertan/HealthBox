import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';

import '../../../core/theme/app_text_theme.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipPath(
              clipper: SideCutClipper(),
              child: Container(
                height: 200,
                color: corPrincipal,
                child: const Center(
                    child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.fromLTRB(20, 150, 20, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.email,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: "Email",
                        enabledBorder: InputBorder.none,
                        labelStyle: const TextStyle(color: Colors.grey)),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.vpn_key,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: "Senha",
                        enabledBorder: InputBorder.none,
                        labelStyle: const TextStyle(color: Colors.grey)),
                  ),
                  Obx(() => Text(
                        controller.loginErroMensagem,
                        style: const TextStyle(color: Colors.redAccent),
                      ))
                ],
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                    child: TextButton(
                      onPressed: () {},
                      child: Text('ESQUECEU A SENHA?',
                          style: TextStyle(
                              fontSize: 11,
                              color: corPrincipal,
                              fontWeight: FontWeight.w700)),
                    ))),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: controller.verificaLogin,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50)),
                    child: const Text('Entrar'))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Não tem conta? ",
                  style: textoInfo,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                          fontSize: 14,
                          color: corPrincipal,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
