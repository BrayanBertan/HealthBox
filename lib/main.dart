import 'package:flutter/material.dart';

void main() {
  runApp(const HealthBoxApp());
}

class HealthBoxApp extends StatelessWidget {
  const HealthBoxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthBox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
