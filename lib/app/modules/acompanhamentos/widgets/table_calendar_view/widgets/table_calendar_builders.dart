import 'package:flutter/material.dart';

class TableCalendarBuilders extends StatelessWidget {
  TextStyle textStyle;
  int itemValue;
  BoxDecoration boxDecoration;
  double width;
  double height;
  TableCalendarBuilders(
      {required this.textStyle,
      required this.itemValue,
      required this.boxDecoration,
      required this.width,
      required this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        decoration: boxDecoration,
        child: Center(
            child: Text(
          '$itemValue',
          style: textStyle,
        )),
      ),
    );
  }
}
