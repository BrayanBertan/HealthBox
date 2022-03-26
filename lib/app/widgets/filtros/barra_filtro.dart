import 'package:flutter/material.dart';
import 'package:healthbox/app/widgets/filtros/dialog_filtros.dart';
import 'package:healthbox/core/values/keys.dart';

class BarraFiltro extends StatelessWidget {
  const BarraFiltro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    // border: InputBorder.none,
                  ),
                )),
              ],
            )),
        IconButton(
          onPressed: () {
            showDialog(context: context, builder: (_) => DialogFiltros());
          },
          icon: Image.asset(
            '${baseImagemUrl}filtro.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
