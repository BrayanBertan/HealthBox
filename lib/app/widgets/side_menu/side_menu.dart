import 'package:flutter/material.dart';
import 'package:healthbox/core/theme/app_colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: corPrincipal,
            ),
            child: Text(
              'Nome usuarior',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
          ),
          ListTile(
            title: Text('Item 2'),
          ),
        ],
      ),
    );
  }
}
