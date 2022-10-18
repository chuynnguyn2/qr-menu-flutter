import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_menu/model/items_model.dart';
import 'package:qr_menu/uploadScreen/items_upload_screen.dart';
import 'package:qr_menu/uploadScreen/menus_edit_delete_screen.dart';

import '../model/menus_model.dart';
import '../widgets/item_info_design.dart';

class ItemScreen extends StatefulWidget {
  final Menus? model;

  const ItemScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Thêm Món Ăn'),
        icon: Icon(Icons.add_card),
        onPressed: (){
          showDialog(
              context: context, builder: (c) => ItemsUploadScreen(model: widget.model));
        },
      ),

      appBar: AppBar(
        actions: [
          TextButton.icon(
            icon: const Icon(
              Icons.queue,
              color: Colors.white,
            ),
            label: const Text(
              'Sửa/Xóa Menu',
              style: TextStyle(color: Colors.white,fontSize: 18),
            ),
            onPressed: () {
              showDialog(context: context, builder: (c)=> MenusEditDeleteScreen(model: widget.model!));

            },
          ),
        ],
      ),
      body: Container(
        child: CustomScrollView(
          slivers: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sellers')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('subMenus')
                  .doc(widget.model?.subMenuID)
                  .collection('menuItems')
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ?  const SliverToBoxAdapter(
                        child: Icon(
                          Icons.shop_2,
                          size: 180,
                          color: Colors.black12,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            Items itemModel = Items.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>,
                            );
                            return ItemInfoDesignWidget(
                              model: itemModel,
                              subMenuID: widget.model!.subMenuID!,
                              onPressed: (){},
                            );
                          },
                          childCount: snapshot.data!.docs.length,
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
