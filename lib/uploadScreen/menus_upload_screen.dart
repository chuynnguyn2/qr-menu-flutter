import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenusUploadScreen extends StatefulWidget {
  const MenusUploadScreen({Key? key,}) : super(key: key);

  @override
  State<MenusUploadScreen> createState() => _MenusUploadScreenState();
}

class _MenusUploadScreenState extends State<MenusUploadScreen> {
  TextEditingController subMenuController = TextEditingController();
  String uniquemenuID = DateTime
      .now()
      .microsecondsSinceEpoch
      .toString();

  saveInfoToFireStore() {
    final ref = FirebaseFirestore.instance
        .collection('sellers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('subMenus');
    ref.doc(uniquemenuID).set({
      'subMenuID': uniquemenuID,
      'subMenuName': subMenuController.text.toString(),
      'sellerUID': FirebaseAuth.instance.currentUser?.uid,
    });
  }

  Container container = Container();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        TextFormField(
          controller: subMenuController,
          decoration: const InputDecoration(
            hintText: "Tên SubMenu",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                child: const Text('Thêm'),
                onPressed: () {
                  saveInfoToFireStore();
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
