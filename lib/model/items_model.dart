class Items {
  String? itemID;
  String? itemName;
  String? itemMaterial;
  String? itemDes;
  String? itemPrice;
  bool itemHot = false;
  String? itemImageUrl;
  String? sellerUID;


  Items({this.itemID, this.itemName,this.itemMaterial, this.itemDes, this.itemPrice, required this.itemHot,this.itemImageUrl, this.sellerUID});

  Items.fromJson(Map<String, dynamic> json)
  {
    itemID = json["itemID"];
    itemName = json["itemName"];
    itemMaterial = json["itemMaterial"];
    itemDes = json["itemDescription"];
    itemPrice = json["itemPrice"];
    itemHot = json["itemHot"];
    itemImageUrl = json["itemImageUrl"];
    sellerUID = json["sellerUID"];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["itemID"] = itemID;
    data["itemName"] = itemName;
    data["itemMaterial"] = itemMaterial;
    data["itemDescription"] = itemDes;
    data["itemHot"] = itemHot;
    data["itemPrice"] = itemPrice;
    data["itemImageUrl"] = itemImageUrl;
    data["sellerUID"] = sellerUID;
    return data;
  }
}
