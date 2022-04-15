import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthbox/app/modules/opinioes/controller.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class CardPesquisa extends GetView<OpinioesController> {
  const CardPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pesquise opiniões sobre medicamentos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 50,
                  child: TextFormField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Pesquisar opiniões",
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: controller.setSearch,
                    child: Icon(
                      Icons.search,
                      color: corPrincipal,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
