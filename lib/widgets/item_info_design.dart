import 'package:flutter/material.dart';
import 'package:qr_menu/mainScreens/item_detail_screen.dart';
import 'package:qr_menu/model/items_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemInfoDesignWidget extends StatefulWidget {
  final String subMenuID;
  final Items? model;
  final VoidCallback onPressed;

  const ItemInfoDesignWidget(
      {Key? key, this.model, required this.onPressed, required this.subMenuID})
      : super(key: key);

  @override
  State<ItemInfoDesignWidget> createState() => _ItemInfoDesignWidgetState();
}

class _ItemInfoDesignWidgetState extends State<ItemInfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                widget.model!.itemImageUrl!,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4 * 9 / 16,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    widget.model!.itemMaterial!,
                    style: GoogleFonts.firaSansCondensed(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
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
                    const Spacer(),
                    TextButton(
                      child: Text('Chỉnh Sửa/Xóa>>'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => ItemDetailScreen(
                                      model: widget.model,
                                      isEditDeleteScreen: true,
                                      subMenuID: widget.subMenuID,
                                    )));
                      },
                    )
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
