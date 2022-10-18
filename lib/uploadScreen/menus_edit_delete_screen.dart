import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_menu/model/menus_model.dart';

class MenusEditDeleteScreen extends StatefulWidget {
  const MenusEditDeleteScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final Menus model;

  @override
  State<MenusEditDeleteScreen> createState() => _MenusEditDeleteScreenState();
}

class _MenusEditDeleteScreenState extends State<MenusEditDeleteScreen> {
  TextEditingController subMenuController = TextEditingController();

  updateInfoToFireStore() {
    final ref = FirebaseFirestore.instance
        .collection('sellers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('subMenus')
        .doc(widget.model.subMenuID)
        .update({'subMenuName': subMenuController.text.toString()});
  }

  deleteInfoToFireStore() {
    final ref = FirebaseFirestore.instance
        .collection('sellers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('subMenus')
        .doc(widget.model.subMenuID)
        .delete();
  }

  Container container = Container();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        TextFormField(
          controller: subMenuController,
          decoration: const InputDecoration(
            hintText: "Tên mới",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                child: const Text('Sửa'),
                onPressed: () {
                  updateInfoToFireStore();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                child: const Text('Xóa'),
                onPressed: () {
                  deleteInfoToFireStore();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                child: const Text('Hủy'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
