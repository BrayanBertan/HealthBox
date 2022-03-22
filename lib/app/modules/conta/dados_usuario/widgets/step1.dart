import 'package:flutter/material.dart';
import 'package:healthbox/core/values/keys.dart';

class Step1Page extends StatelessWidget {
  const Step1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => {},
          child: CircleAvatar(
              child: Image.asset('${baseImagemUrl}user_pic.png'),
              minRadius: 75,
              maxRadius: 100),
        ),
        TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
              icon: const Icon(
                Icons.person,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Nome",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
        ),
        TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
              icon: const Icon(
                Icons.phone,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100)),
              labelText: "Telefone",
              enabledBorder: InputBorder.none,
              labelStyle: const TextStyle(color: Colors.grey)),
        ),
        GestureDetector(
          onTap: () async {
            final DateTime selected = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2025),
                ) ??
                DateTime.now();
          },
          child: Row(
            children: [
              Image.asset(
                '${baseImagemUrl}calendario.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              Text('${DateTime.now()}')
            ],
          ),
        ),
      ],
    );
  }
}
