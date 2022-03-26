import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_text_theme.dart';

import '../../core/values/keys.dart';

class DialogAddVinculo extends StatelessWidget {
  const DialogAddVinculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Novo vinculo',
              style: titulo,
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.search,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      labelText: "Digite o CRM do seu médico",
                      enabledBorder: InputBorder.none,
                      labelStyle: const TextStyle(color: Colors.grey)),
                )),
                ElevatedButton(onPressed: () {}, child: const Text('Buscar'))
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                  child: Image.asset('${baseImagemUrl}user_pic.png'),
                  minRadius: 50,
                  maxRadius: 50),
              title: Text('Luis Vidal Miranda'),
              trailing: ElevatedButton(
                  onPressed: () {}, child: const Icon(Icons.person_add)),
            )
          ],
        ),
      ),
    );
  }
}
