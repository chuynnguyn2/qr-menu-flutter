class Menus {
  String? subMenuID;
  String? subMenuName;
  String? sellerUID;

  Menus({this.subMenuID, this.subMenuName, this.sellerUID});

  Menus.fromJson(Map<String, dynamic> json)
  {
    subMenuID = json["subMenuID"];
    subMenuName = json["subMenuName"];
    sellerUID = json["sellerUID"];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["subMenuID"] = subMenuID;
    data["subMenuName"] = subMenuName;
    data["sellerUID"] = sellerUID;
    return data;
  }
}
