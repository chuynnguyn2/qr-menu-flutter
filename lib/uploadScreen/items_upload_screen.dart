import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_menu/model/menus_model.dart';

class ItemsUploadScreen extends StatefulWidget {
  final Menus? model;

  const ItemsUploadScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  XFile? imageXFile;
  Image imageFile = Image.asset('images/logo.png');
  ImagePicker _picker = ImagePicker();
  String fileName = DateTime.now().microsecondsSinceEpoch.toString();
  String? itemImageUrl;

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDesController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController(text: '0');
  TextEditingController itemMaterialController = TextEditingController();
  String? itemHotText = 'Không';
  bool itemHotController = false;

  String uniqueitemID = DateTime.now().microsecondsSinceEpoch.toString();

  saveImageToStorage() async {
    //upload photo to storage
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef
        .child('sellers')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(widget.model!.subMenuID!)
        .child(uniqueitemID);
    UploadTask uploadTask = imageRef.putFile(File(imageXFile!.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) {
      itemImageUrl = url;
    });
    saveInfoToFireStore();
  }

  saveInfoToFireStore() async {
    //upload other info
    final ref = FirebaseFirestore.instance
        .collection('sellers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('subMenus')
        .doc(widget.model?.subMenuID)
        .collection('menuItems');
    ref.doc(uniqueitemID).set({
      'itemID': uniqueitemID,
      'itemName': itemNameController.text.toString(),
      'itemMaterial': itemMaterialController.text.toString(),
      'itemDescription': itemDesController.text.toString(),
      'itemImageUrl': itemImageUrl,
      'itemPrice': itemPriceController.text.toString(),
      'itemHot': itemHotController,
      'subMenuId': widget.model?.subMenuID,
      'sellerUID': FirebaseAuth.instance.currentUser?.uid,
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
            TextFormField(
              controller: itemNameController,
              decoration: const InputDecoration(
                hintText: "Tên Món Ăn",
              ),
            ),
            TextFormField(
              controller: itemMaterialController,
              decoration: const InputDecoration(
                hintText: "Tên Nguyên Liệu",
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
                    child: const Text('Thêm'),
                    onPressed: () {
                      saveImageToStorage();
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
        ),
      ),
    );
  }
}
