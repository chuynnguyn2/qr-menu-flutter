import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_menu/mainScreens/item_detail_screen.dart';

import '../model/items_model.dart';

class ItemsEditScreen extends StatefulWidget {
  final Items model;
  final String subMenuID;

  const ItemsEditScreen(
      {Key? key, required this.model, required this.subMenuID})
      : super(key: key);

  @override
  State<ItemsEditScreen> createState() => _ItemsEditScreenState();
}

class _ItemsEditScreenState extends State<ItemsEditScreen> {
  XFile? imageXFile;
  late Image imageFile = Image.network(widget.model.itemImageUrl!);
  ImagePicker _picker = ImagePicker();
  String fileName = DateTime.now().microsecondsSinceEpoch.toString();
  String? itemImageUrl;

  late TextEditingController itemNameController = TextEditingController(text: widget.model.itemName);
  late TextEditingController itemDesController = TextEditingController(text: widget.model.itemDes);
  late TextEditingController itemPriceController = TextEditingController(text: widget.model.itemPrice);
  late TextEditingController itemMaterialController = TextEditingController(text: widget.model.itemMaterial);
  String? itemHotText = 'Không';
  bool itemHotController = false;

  saveImageToStorage() async {
    //upload photo to storage
    if (imageXFile!=null) {
      final storageRef = FirebaseStorage.instance.ref();

      final newImageRef = storageRef
          .child('sellers')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(widget.subMenuID)
          .child(widget.model.itemID!);

      UploadTask uploadTask = newImageRef.putFile(File(imageXFile!.path));

    }
  }

  _editItem() async {
    //upload other info
    final ref = FirebaseFirestore.instance
        .collection('sellers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('subMenus')
        .doc(widget.subMenuID)
        .collection('menuItems')
        .doc(widget.model.itemID)
        .update({
      'itemName': itemNameController.text.toString(),
      'itemMaterial': itemMaterialController.text.toString(),
      'itemDescription': itemDesController.text.toString(),
      'itemPrice': itemPriceController.text.toString(),
      'itemHot': itemHotController,
    });
  }

  _imagePick() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
      imageFile = Image.file(File(imageXFile!.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 3 / 4,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: imageFile,
                )),
            ElevatedButton(
              child: const Text('Chọn Ảnh'),
              onPressed: () {
                _imagePick();
              },
            ),
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(
                hintText: widget.model.itemName!,
              ),
            ),
            TextFormField(
              controller: itemDesController,
              decoration: const InputDecoration(
                hintText: "Mô Tả",
              ),
            ),
            TextFormField(
              controller: itemPriceController,
              decoration:
                  const InputDecoration(hintText: "Giá Tiền", suffixText: 'K'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Text('Có phải món ăn phổ biến không?'),
                Spacer(),
                DropdownButton<String>(
                  value: itemHotText,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      itemHotText = newValue!;
                      itemHotText == 'Có'
                          ? itemHotController = true
                          : itemHotController = false;
                    });
                  },
                  items: <String>['Không', 'Có']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    child: const Text('Xác Nhận'),
                    onPressed: () {
                      saveImageToStorage();
                      _editItem();
                      Navigator.pop(context);

                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemDetailScreen(model: widget.model, subMenuID: widget.subMenuID,isEditDeleteScreen: true,)));
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
        ),
      ),
    );
  }
}
