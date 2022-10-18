import 'package:flutter/material.dart';
import 'package:qr_menu/model/items_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemDrawer extends StatefulWidget {
  const ItemDrawer({Key? key}) : super(key: key);

  @override
  State<ItemDrawer> createState() => _ItemDrawerState();
}

class _ItemDrawerState extends State<ItemDrawer> {
  String name ='';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Text(
        name,
      ),

    );
  }
}
