
import 'package:pizza_order/views/product/ProductController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pizza_order/views/product/logic/product.dart';
import 'package:pizza_order/views/product/logic/product_contoller.dart';
import 'package:pizza_order/views/product/logic/product_service.dart';

Future<void> main() async {
  runApp(TestApp());
  controller();
}

Future<void> model() async {
  var service = ProductServices();

  // A. Create Product
  var product = Product(
    imageNetwork:
        'https://api-portfolio.gft.academy/storage/images/fileAlbum_1690868675371.png',
    name: 'FRANKFURTER BBQ',
    category: 'Pizza',
    desc: 'Frankfurter Sapi, Daging Sapi Cincang, dan Keju Mozzarella',
    iconPrep: '10',
    iconCook: '15',
    iconPrice: 56,
    bonusBundling: [
      BonusBundling(
        title: 'SALMON AGLIO OLIO',
        image:
            'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689842317018.png',
      ),
      BonusBundling(
        title: 'CHICKEN BITES',
        image:
            'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689844127985.png',
      ),
      BonusBundling(
        title: 'TROPICAL PUNCH',
        image:
            'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689843901683.png',
      ),
    ],
  );
  service.create(product);

  // B. Read Product
  /** tanpa await akan mengakibatkan :
   *  I/flutter ( 9339): Instance of 'Future<List<Product>?> **/
  List<Product>? listProduct = await service.read();
  print(listProduct);

  // C. Update Product
  Product? findProductById(String id) {
    for (Product p in listProduct!) {
      if (p.id == id) {
        return p;
      }
    }
    return null;
  }

  var updateProduct = findProductById('SnZQhkd');
  updateProduct?.name = 'Soto Ayam';
  updateProduct?.iconPrice = 11.8;
  service.update(updateProduct!);

  // D. Delete Product
  service.remove('SnZQhkd');
}

Future<void>  controller() async {
  var controller = Get.put(PMController());

  // A. Create Product
  var product = Product(
    imageNetwork:
    'https://api-portfolio.gft.academy/storage/images/fileAlbum_1690868675371.png',
    name: 'Ayam PakCoy Pedas',
    category: 'Pizza',
    desc: 'Frankfurter Sapi, Daging Sapi Cincang, dan Keju Mozzarella',
    iconPrep: '10',
    iconCook: '15',
    iconPrice: 56,
    bonusBundling: [
      BonusBundling(
        title: 'SALMON AGLIO OLIO',
        image:
        'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689842317018.png',
      ),
      BonusBundling(
        title: 'CHICKEN BITES',
        image:
        'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689844127985.png',
      ),
      BonusBundling(
        title: 'TROPICAL PUNCH',
        image:
        'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689843901683.png',
      ),
    ],
  );
  controller.addProduct(product);

  // B. Read Product
  await controller.readData();

  // C. Update Product
  var updateProduct = controller.findProductById('SnZQhkd');
  updateProduct!.name = 'Soto Ayam';
  updateProduct!.iconPrice = 11.8;
  controller.updateProduct(updateProduct!);

  // D. Delete Product
  var deleteProduct = controller.findProductById('SnZQhkd');
  controller.deleteProduct(deleteProduct!);
}


// class ProductServices {
//   Future<void> create(Products t) async {
//     final response = await post(
//       Uri.parse('http://192.168.100.175:3000/products'),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(t.toJson()),
//     );
//
//     if (response.statusCode == 201) {
//       print('Product created successfully!');
//     } else {
//       throw Exception(
//           'Failed to create product. Error: ${response.statusCode}');
//     }
//   }
//
//   Future<List<Products>?> read() async {
//     final response = await get(
//       Uri.parse('http://192.168.100.175:3000/products'),
//       headers: {"Content-Type": "application/json"},
//     );
//
//     if (response.statusCode == 200) {
//       List jsonResponse = jsonDecode(response.body);
//       return jsonResponse.map((e) => Products.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load Products');
//     }
//   }
//
//   Future<void> remove(String id) async {
//     final url = Uri.parse('http://192.168.100.175:3000/products/$id');
//     final response = await delete(url);
//
//     if (response.statusCode == 200) {
//       print('Product deleted successfully!');
//     } else {
//       throw Exception(
//           'Failed to delete product. Error: ${response.statusCode}');
//     }
//   }
//
//   Future<void> update(Products t) async {
//     final response = await put(
//       Uri.parse('http://192.168.100.175:3000/products/${t.id}'),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(t.toJson()),
//     );
//
//     if (response.statusCode == 200) {
//       print('Product updated successfully!');
//     } else {
//       throw Exception(
//           'Failed to update customer. Error: ${response.statusCode}');
//     }
//   }
// }

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
// var controller = Get.put(PMController());