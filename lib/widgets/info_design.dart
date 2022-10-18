import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_menu/mainScreens/items_screen.dart';
import 'package:qr_menu/model/menus_model.dart';

class InfoDesignWidget extends StatefulWidget {
  final Menus? model;
  final BuildContext? context;

  const InfoDesignWidget({Key? key, this.model, this.context}) : super(key: key);

  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.folder,
              size: 90,
              color: Colors.cyan,
            ),
            Text(
              widget.model!.subMenuName!,
              style: GoogleFonts.roboto(fontSize: 18)
            )
          ],
        ),
      ),
    );
  }
}
