import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_menu/model/items_model.dart';
import 'package:qr_menu/model/menus_model.dart';

import 'item_info_draft_menu.dart';

class DraftMenuItem extends StatefulWidget {
  DraftMenuItem({Key? key, required this.menuModel}) : super(key: key);
  final Menus? menuModel;

  @override
  State<DraftMenuItem> createState() => _DraftMenuItemState();
}

class _DraftMenuItemState extends State<DraftMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sellers')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('subMenus')
              .doc(widget.menuModel?.subMenuID)
              .collection('menuItems')
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const Text('Chua co Mon An')
                : ListView.builder(
                    itemBuilder: (context, index) {
                      Items itemModel = Items.fromJson(
                        snapshot.data!.docs[index].data()!
                            as Map<String, dynamic>,
                      );
                      return ItemInfoDraftDesignWidget(
                        model: itemModel,
                        context: context,
                        subMenuID: widget.menuModel!.subMenuID!,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
          }),
    );
  }
}
