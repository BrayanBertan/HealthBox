import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.height * 0.15,
          child: CircularProgressIndicator(
            color: corPrincipal,
          ),
        ),
      ),
    );
  }
}
