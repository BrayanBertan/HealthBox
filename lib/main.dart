import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const HealthBoxApp());
}

class HealthBoxApp extends StatelessWidget {
  const HealthBoxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthBox',
      theme: appThemeData,
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('aaaaaaa')),
              Text('aaaaaaa')
            ],
          ),
        ),
      ),
    );
  }
}
