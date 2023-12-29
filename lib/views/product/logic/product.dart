// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? id;
  String imageNetwork;
  String name;
  String category;
  String desc;
  String iconPrep;
  String iconCook;
  double iconPrice;
  List<BonusBundling> bonusBundling;

  Product({
    this.id,
    required this.imageNetwork,
    required this.name,
    required this.category,
    required this.desc,
    required this.iconPrep,
    required this.iconCook,
    required this.iconPrice,
    required this.bonusBundling,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    imageNetwork: json["imageNetwork"],
    name: json["name"],
    category: json["category"],
    desc: json["desc"],
    iconPrep: json["iconPrep"],
    iconCook: json["iconCook"],
    iconPrice: json["iconPrice"],
    bonusBundling: List<BonusBundling>.from(json["bonusBundling"].map((x) => BonusBundling.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "imageNetwork": imageNetwork,
    "name": name,
    "category": category,
    "desc": desc,
    "iconPrep": iconPrep,
    "iconCook": iconCook,
    "iconPrice": iconPrice,
    "bonusBundling": List<dynamic>.from(bonusBundling.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'Product{id: $id, imageNetwork: $imageNetwork, name: $name, category: $category, desc: $desc, iconPrep: $iconPrep, iconCook: $iconCook, iconPrice: $iconPrice, bonusBundling: $bonusBundling}';
  }
}

class BonusBundling {
  String title;
  String image;

  BonusBundling({
    required this.title,
    required this.image,
  });

  factory BonusBundling.fromJson(Map<String, dynamic> json) => BonusBundling(
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
  };

  @override
  String toString() {
    return 'BonusBundling{title: $title, image: $image}';
  }
}
