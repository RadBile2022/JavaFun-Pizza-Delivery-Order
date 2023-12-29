import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pizza_order/routes/endpoint-rest-api.dart';

// class Products {
//   String? id;
//   String imageNetwork;
//   String name;
//   String category;
//   String desc;
//   String iconPrep;
//   String iconCook;
//   double iconPrice;
//   List<Bonus> bonusBundling ;
//
//   Products({
//     this.id,
//     required this.imageNetwork,
//     required this.name,
//     required this.category,
//     required this.desc,
//     required this.iconPrep,
//     required this.iconCook,
//     required this.iconPrice,
//     required this.bonusBundling,
//   });
//
//   @override
//   String toString() {
//     return 'Product{imageAsset: $imageNetwork, name: $name, category: $category, desc: $desc, iconPrep: $iconPrep, iconCook: $iconCook, iconPrice: $iconPrice, bonusBundling: $bonusBundling}';
//   }
//
//   // json['']
//
//   factory Products.fromJson(Map<String, dynamic> json) {
//     return Products(
//       id: json['id'],
//       imageNetwork: json['imageNetwork'],
//       name: json['name'],
//       category: json['category'],
//       desc: json['desc'],
//       iconPrep: json['iconPrep'],
//       iconCook: json['iconCook'],
//       iconPrice: (json['iconPrice'] as num).toDouble(),
//       bonusBundling: List<Bonus>.from(
//           json["bonusBundling"].map((x) => Bonus.fromJson(x))),
//       // bonusBundling: (json['bonusBundling'] as List<dynamic>)
//       //     .map((e) => Bonus.fromJson(e))
//       //     .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "imageNetwork": imageNetwork,
//       "name": name,
//       "category": category,
//       "desc": desc,
//       "iconPrep": iconPrep,
//       "iconCook": iconCook,
//       "iconPrice": iconPrice,
//       "bonusBundling": bonusBundling.map((bonus) => bonus.toJson()).toList(),
//     };
//   }
// }

class Bonus {
  String title;
  String image;

  Bonus({required this.title, required this.image});

  @override
  String toString() {
    return 'Bonus{title: $title, image: $image}';
  }

  factory Bonus.fromJson(Map<String, dynamic> json) {
    return Bonus(title: json['title'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
    };
  }
}





// class ProductService implements Services<Product> {
//   @override
//   Future<void> create(Product t) async {
//     final response = await post(
//       Uri.parse(Endpoint.apiProduct),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(t.toJson()),
//     );
//
//     if (response.statusCode == 201) {
//       print('Product created successfully!');
//     } else {
//       print('Failed to create product. Error: ${response.statusCode}');
//     }
//   }
//
//   @override
//   Future<List<Product>?> read() async {
//     final response = await get(
//       Uri.parse(Endpoint.apiProduct),
//       headers: {"Content-Type": "application/json"},
//     );
//
//     if (response.statusCode == 200) {
//       List jsonResponse = jsonDecode(response.body);
//       return jsonResponse.map((e) => Product.fromJson(e)).toList();
//       print(jsonResponse);
//     } else {
//       throw Exception('Failed to load Products');
//     }
//   }
//
//   @override
//   Future<void> remove(String id) async {
//     final url = Uri.parse('${Endpoint.apiProduct}/$id');
//     final response = await delete(url);
//
//     if (response.statusCode == 200) {
//       print('Product deleted successfully!');
//     } else {
//       print('Failed to delete product. Error: ${response.statusCode}');
//     }
//   }
//
//   @override
//   Future<void> update(Product t) async {
//     final response = await put(
//       Uri.parse('${Endpoint.apiProduct}/${t.id}'),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(t.toJson()),
//     );
//
//     if (response.statusCode == 200) {
//       print('Customer updated successfully!');
//     } else {
//       print('Failed to update customer. Error: ${response.statusCode}');
//     }
//   }
// }

// class Product {
//   String? id, name;
//   double? price;
//   File? image;
//
//   Product();
//
//   Product.instance(
//       {required this.id,
//       required this.name,
//       required this.price,
//       required this.image});
//
//   @override
//   String toString() {
//     return 'Product{id: $id, name: $name, price: $price, image: $image}';
//   }
//
//   // Product.fromJson(Map<String, dynamic> json)
//   //     : id = json['id'],
//   //       name = json['name'],
//   //       price = (json['price'] as num).toDouble(),
//   //       image = json['image'];
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product.instance(
//       id: json['id'],
//       name: json['name'],
//       price: (json['price'] as num).toDouble(),
//       image: json['image'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'name': name, 'price': price, 'image': image};
//   }
// }
