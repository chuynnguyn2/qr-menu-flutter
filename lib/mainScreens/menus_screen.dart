import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_menu/mainScreens/draft_menu.dart';
import 'package:qr_menu/model/menus_model.dart';
import 'package:qr_menu/uploadScreen/menus_upload_screen.dart';
import 'package:qr_menu/widgets/info_design.dart';
class MenusScreen extends StatefulWidget {
  const MenusScreen({Key? key}) : super(key: key);

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {

  defaultScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shop_2, color: Colors.black12, size: 200.0),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            child: const Text(
              "Thêm Menu Mới",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const DraftMenu()));
        },
        label: const Text(
          'Xem Menu Của Bạn',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: [
          TextButton.icon(
            icon: const Icon(
              Icons.post_add,
              color: Colors.white,
            ),
            label: const Text(
              'Thêm Menu',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              showDialog(
                  context: context, builder: (c) => const MenusUploadScreen());
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sellers')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('subMenus')
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: defaultScreen(),
              )
                  : SliverGrid(
                gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 10.0,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Menus model = Menus.fromJson(
                      snapshot.data!.docs[index].data()!
                      as Map<String, dynamic>,
                    );
                    return InfoDesignWidget(
                      model: model,
                      context: context,
                    );
                  },
                  childCount: snapshot.data!.docs.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
