import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_menu/model/items_model.dart';
import 'package:qr_menu/uploadScreen/items_edit_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen(
      {Key? key,
      required this.model,
      required this.isEditDeleteScreen,
      required this.subMenuID})
      : super(key: key);

  final Items? model;
  final String subMenuID;
  final bool isEditDeleteScreen;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  _deleteItem() {
    final ref = FirebaseFirestore.instance
        .collection('sellers')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('subMenus')
        .doc(widget.subMenuID)
        .collection('menuItems')
        .doc(widget.model?.itemID)
        .delete();
    Navigator.pop(context);
  }

  _editItem(){
    Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsEditScreen(model: widget.model!, subMenuID: widget.subMenuID)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model!.itemName!),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      widget.model!.itemImageUrl!,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6 * 3 / 4,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.model!.itemHot!,
                  child: Text(
                    'Món phổ biến',
                    style:
                        GoogleFonts.firaSans(fontSize: 15.0, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nguyên Liệu:',
                        style: GoogleFonts.firaSans(
                            fontSize: 20.0, color: Colors.indigo),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(widget.model!.itemMaterial!),
                    ],
                  ),
                ),
                Divider(
                  height: 3.0,
                  thickness: 1.0,
                  color: Colors.grey[300],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mô Tả:',
                        style: GoogleFonts.firaSans(
                            fontSize: 20.0, color: Colors.indigo),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(widget.model!.itemDes!),
                    ],
                  ),
                ),
                Divider(
                  height: 3.0,
                  thickness: 1.0,
                  color: Colors.grey[300],
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Giá: ${widget.model!.itemPrice!} K')),
              ],
            ),
          ),
          Center(
            child: Visibility(
              visible: widget.isEditDeleteScreen,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: [
                    ElevatedButton(
                      child: Text('Chỉnh Sửa'),
                      onPressed: () {
                        _editItem();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff5800FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5.0,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      child: Text('Xóa'),
                      onPressed: () {
                        _deleteItem();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff5800FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
