import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/app/widgets/filtros/card_pesquisa.dart';
import 'package:healthbox/app/widgets/filtros/header_filtros.dart';
import 'package:healthbox/app/widgets/side_menu/side_menu.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/values/keys.dart';

class OpinioesPage extends GetView<OpinioesController> {
  OpinioesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CardPesquisa(),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeaderFiltro(),
                    const Divider(),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                margin: const EdgeInsets.only(left: 25.0),
                                padding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                                child: Card(
                                  margin: const EdgeInsets.only(bottom: 25),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 15,
                                            right: 15,
                                            bottom: 40),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eros justo, viverra quis nunc eget, laoreet volutpat nulla.',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                'Morbi fermentum ipsum a eros consectetur ultricies. Maecenas scelerisque ut tortor ut maximus. Nullam vulputate, risus non semper malesuada, quam nunc sollicitudin mi, eget dignissim lectus quam sit amet sapien. Aenean volutpat lectus ac ex hendrerit, sit amet efficitur tortor molestie. Curabitur enim risus, venenatis a diam non, gravida fringilla orci. Proin ac hendrerit purus. Mauris id magna eu tellus sodales faucibus. Aenean vitae orci eu tortor lobortis tristique.',
                                                maxLines: 3,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          child: Container(
                                            height: 40,
                                            color: corPrincipal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        '${baseImagemUrl}gostar.png',
                                                        width: 25),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text('10'),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        Image.asset(
                                                            '${baseImagemUrl}dislike.png',
                                                            width: 25)
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text('5')
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        '${baseImagemUrl}comments.png',
                                                        width: 25),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text('10')
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  child: CircleAvatar(
                                child:
                                    Image.asset('${baseImagemUrl}user_pic.png'),
                              )),
                            ],
                          );
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
