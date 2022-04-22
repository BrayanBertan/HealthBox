import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/data/enums/tipo_usuario.dart';
import 'package:healthbox/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/values/keys.dart';
import '../../modules/login/controller.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    dynamic usuario;
    usuario = loginController.getLogin();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: corPrincipal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Olá, ${usuario.nome}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    usuario?.fotoPath == null
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                image:
                                    AssetImage('${baseImagemUrl}user_pic.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: usuario!.fotoPath!,
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                                child: const CircleAvatar(
                                  maxRadius: 45,
                                  minRadius: 45,
                                ),
                                baseColor: corPrincipal50,
                                highlightColor: corPrincipal),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed('/conta');
                        },
                        child: const Text(
                          'Minha conta',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )),
                    TextButton(
                        onPressed: Get.find<LoginController>().logout,
                        child: const Text(
                          'sair',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Get.offAllNamed('/');
            },
            leading:
                Image.asset('${baseImagemUrl}acompanhamentos.png', width: 40),
            title: const Text(
              'Acompanhamentos',
              style: TextStyle(fontSize: 17),
            ),
          ),
          const Divider(),
          usuario.tipo == TipoUsuario.PACIENTE
              ? ListTile(
                  onTap: () {
                    Get.offAllNamed('/');
                  },
                  leading:
                      Image.asset('${baseImagemUrl}feedback.png', width: 40),
                  title: const Text('Opiniões', style: TextStyle(fontSize: 17)),
                )
              : Container(),
        ],
      ),
    );
  }
}
