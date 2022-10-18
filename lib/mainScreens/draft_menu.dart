import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_menu/model/items_model.dart';
import 'package:qr_menu/model/menus_model.dart';
import 'package:qr_menu/widgets/item_choosed_drawer.dart';
import 'package:qr_menu/widgets/item_draft_menu.dart';

class DraftMenu extends StatefulWidget {
  const DraftMenu({Key? key}) : super(key: key);

  @override
  State<DraftMenu> createState() => _DraftMenuState();
}

class _DraftMenuState extends State<DraftMenu> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Menus? menuModel;
  Menus? firstMenuModel;
  Items? itemModel;
  int isSelected = -1;

  _isSelected (int index){
    setState(() {
      isSelected = index;
    });
  }

  _initfirstMenuModel(Menus? tpmenuModel) {
    setState(() {
      firstMenuModel = tpmenuModel;
    });
  }

  _onMenuModelChanged(Menus? tpmenuModel) {
    setState(() {
      menuModel = tpmenuModel;
    });
  }

  //
  // @override
  // void initState() {
  //   final docRef = db
  //       .collection('sellers')
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .collection('subMenus')
  //       .orderBy('dateAdded')
  //       .limit(1).get().then((QuerySnapshot doc) {
  //     setState(() {
  //       menuModel = Menus.fromJson(doc.docs[0].data() as Map<String, dynamic>);
  //     });
  //   });
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemDrawer()));
        },
      ),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'QR MENU',
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //     padding: const EdgeInsets.only(left: 10.0, top: 30.0),
            //     child: RichText(
            //       text: TextSpan(
            //         children: [
            //           TextSpan(
            //             text: 'Xin Chào ',
            //             style: GoogleFonts.patrickHandSc(
            //                 fontSize: 30.0, color: Colors.orange),
            //           ),
            //           WidgetSpan(
            //             child: Icon(
            //               Icons.waving_hand,
            //               color: Colors.indigo[300],
            //             ),
            //           )
            //         ],
            //       ),
            //     )),
            // Padding(
            //     padding: const EdgeInsets.only(
            //       left: 10.0,
            //       top: 5.0,
            //       bottom: 10.0,
            //     ),
            //     child: Text(
            //       'Mời bạn chọn món ăn nhé!',
            //       style:
            //           GoogleFonts.roboto(fontSize: 20.0, color: Colors.orange),
            //     )),
            Container(
              margin:
                  const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
              child: SizedBox(
                height: 40,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('sellers')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection('subMenus')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const Text('Bạn chưa có Menu nào!')
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Menus model = Menus.fromJson(
                                snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>,
                              );

                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: isSelected == index? Colors.orange : Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        model.subMenuName!,
                                        style: TextStyle(
                                          color: isSelected == index? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    _isSelected(index);
                                    setState(() {
                                      _onMenuModelChanged(model);
                                    });
                                  },
                                ),
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                          );
                  },
                ),
              ),
            ),
            DraftMenuItem(menuModel: menuModel ?? firstMenuModel,),
          ],
        ),
      ),
    );
  }
}
