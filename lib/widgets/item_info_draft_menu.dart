import 'package:flutter/material.dart';
import 'package:qr_menu/mainScreens/item_detail_screen.dart';
import 'package:qr_menu/model/items_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemInfoDraftDesignWidget extends StatefulWidget {
  final Items model;
  final String subMenuID;
  final BuildContext? context;

  // final int index;

  const ItemInfoDraftDesignWidget(
      {Key? key, required this.model, this.context, required this.subMenuID})
      : super(key: key);

  @override
  State<ItemInfoDraftDesignWidget> createState() =>
      _ItemInfoDraftDesignWidgetState();
}

class _ItemInfoDraftDesignWidgetState extends State<ItemInfoDraftDesignWidget> {
  _getSharedInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('itemName', widget.model.itemName!);
    prefs.setString('itemPrice', widget.model.itemPrice!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: widget.model.itemHot ? Colors.orange[100] : Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4 * 3 / 4,
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  widget.model.itemImageUrl!,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            margin: const EdgeInsets.symmetric(vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    widget.model!.itemName!,
                    style: GoogleFonts.firaSans(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    widget.model!.itemDes!,
                    style: GoogleFonts.firaSansCondensed(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.model.itemHot ? true : false,
                  child: Text(
                    'Món phổ biến',
                    style:
                        GoogleFonts.firaSans(color: Colors.red, fontSize: 12),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.model!.itemPrice!} K',
                      style: GoogleFonts.firaSansCondensed(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                    GoogleFonts.firaSansCondensed(
                                        fontSize: 15)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orange),
                              ),
                              onPressed: () {
                                _getSharedInfo();
                              },
                              child: const Text(
                                'Chọn',
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'Xem chi tiết >>',
                                style: GoogleFonts.firaSans(
                                    fontSize: 12, color: Colors.orange),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => ItemDetailScreen(
                                              model: widget.model,
                                              isEditDeleteScreen: false,
                                              subMenuID: widget.subMenuID,
                                            )));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
