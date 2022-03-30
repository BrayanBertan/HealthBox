import 'package:flutter/material.dart';

import '../../../../core/values/keys.dart';

class TileSolicitacoesVinculo extends StatelessWidget {
  const TileSolicitacoesVinculo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.notifications_on),
      title: const Text('Solicitações de vinculo'),
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        child: Image.asset(
                            '${baseImagemUrl}user_pic.png'),
                        minRadius: 50,
                        maxRadius: 50),
                    title: Text('Luis Vidal Miranda'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.person_add),
                      color: Colors.green,
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
