import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/login/controller.dart';
import 'package:healthbox/core/values/keys.dart';
import 'package:healthbox/routes/app_pages.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_theme.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);
  //final controller = Get.find<LoginController>();
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          right: -getSmallDiameter(context) / 3,
          top: -getSmallDiameter(context) / 3,
          child: Container(
            child: const Center(
              child: Text(
                nomeApp,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            width: getSmallDiameter(context),
            height: getSmallDiameter(context),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [corPrincipal, corPrincipal500],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
        ),
        Positioned(
          left: -getBiglDiameter(context) / 4,
          top: -getBiglDiameter(context) / 4,
          child: Container(
            child: const Center(
              child: Text(
                "Login",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            width: getBiglDiameter(context),
            height: getBiglDiameter(context),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [corPrincipal, corPrincipal500],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: controller.setEmail,
                      decoration: InputDecoration(
                          icon: const Icon(
                            Icons.email,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100)),
                          labelText: "E-mail",
                          enabledBorder: InputBorder.none,
                          labelStyle: const TextStyle(color: Colors.grey)),
                    ),
                    Obx(() {
                      return TextFormField(
                        onChanged: controller.setSenha,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.password,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Senha",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey),
                            errorText: controller.loginErroMensagem),
                      );
                    }),
                  ],
                ),
              ),
              // Align(
              //     alignment: Alignment.centerRight,
              //     child: Container(
              //         margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
              //         child: TextButton(
              //           onPressed: () {},
              //           child: Text('ESQUECEU A SENHA?',
              //               style: TextStyle(
              //                   fontSize: 11,
              //                   color: corPrincipal,
              //                   fontWeight: FontWeight.w700)),
              //         ))),
              Align(
                  alignment: Alignment.center,
                  child: Obx(() => ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : controller.verificaLogin,
                      style: ElevatedButton.styleFrom(
                          onSurface: corPrincipal300,
                          fixedSize: const Size(150, 50)),
                      child: const Text('Entrar')))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Não tem conta? ",
                    style: textoInfo,
                  ),
                  TextButton(
                      onPressed: () => Get.offNamed(Routes.DADOS_USUARIO),
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
        )
      ]),
    );
  }
}
