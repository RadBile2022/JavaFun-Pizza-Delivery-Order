// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'views/product/ProductController.dart';
// import 'dart:convert';
// import 'package:http/http.dart';
// // kalau gak ada material dart tetap error karena dia render flutter bukan sekedar dart.
// Future<void> main() async {
//   runApp(TestApp());
//   model();
// }
//
// void entitas() {
//   // A. Create Product
//   var product = Product.instance(
//       id: '32wZx12', name: 'Nasi Pecel', price: 13.5, image: null);
//
//   // B. Uji Coba Product
//   print(product);
// }
//
// Future<void> model() async {
//   // // A. Create Product
//   // var product = Product.instance(
//   //     id: '32wZx12', name: 'Nasi Pecel', price: 13.5, image: null);
//   var service = ProductServices();
//   // service.create(product);
//   // B. Read Product
//   // print(await service.read());
//   /**
//    *  tanpa await akan mengakibatkan :
//    *  I/flutter ( 9339): Instance of 'Future<List<Product>?>
//    **/
//   List<Products>? listProduct = await service.read();
//   // Product? findProductById(String id) {
//   //   for (Product p in listProduct!) {
//   //     if (p.id == id) {
//   //       return p;
//   //     }
//   //   }
//   //   return null;
//   // }
//   //
//   // // C. Update Product
//   // var updateProduct = findProductById('32wZx12');
//   // updateProduct?.name = 'Soto Ayam';
//   // updateProduct?.price = 11.8;
//   // service.update(updateProduct!);
//
//   // D. Delete Product
//   // service.remove('32wZx12');
// }
//
// // void controller() {
// //   // A. Create Product
// //   var product = Product.instance(
// //       id: '32wZx12', name: 'Nasi Pecel', price: 13.5, image: null);
// //   var controller = Get.put(PMController());
// //   controller.addProduct(product);
// //
// //   // B. Read Product
// //   print(controller.service);
// //
// //   // C. Update Product
// //   var updateProduct = controller.findProductById('32wZx12');
// //   updateProduct?.name = 'Soto Ayam';
// //   updateProduct?.price = 11.8;
// //   controller.updateProduct(updateProduct!);
// //
// //   // D. Delete Product
// //   controller.deleteProduct(updateProduct);
// // }
//
// class TestApp extends StatelessWidget {
//   var controller = Get.put(PMController());
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pizza Delivery',
//       theme: ThemeData(
//         textTheme: TextTheme(
//           titleLarge: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//           titleSmall: TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.blueAccent),
//       ),
//       home: Container(),
//     );
//   }
// }
//
//
//
//
//
// class ProductServices   {
//   Future<void> create(Product t) async {
//     final response = await post(
//       Uri.parse('http://192.168.100.175:3000/products'),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(t.toJson()),
//     );
//
//     if (response.statusCode == 200) {
//       print('Product created successfully!');
//     } else {
//       throw Exception('Failed to create product. Error: ${response.statusCode}');
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
//       List jsonresponse = jsonDecode(response.body);
//       print(jsonresponse);
//       // return jsonresponse.map((e) => Product.fromJson(e)).toList();
//     } else {
//       throw Exception('Failde to load Products');
//     }
//   }
//
//   Future<void> remove(String id) async {
//     final url = Uri.parse('http://192.168.1.219:3000/products/$id');
//     final response = await delete(url);
//
//     if (response.statusCode == 200) {
//       print('Product deleted successfully!');
//     } else {
//       print('Failed to delete product. Error: ${response.statusCode}');
//     }
//   }
//
//   Future<void> update(Product t) async {
//     final response = await put(
//       Uri.parse('http://192.168.1.219:3000/products/${t.id}'),
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