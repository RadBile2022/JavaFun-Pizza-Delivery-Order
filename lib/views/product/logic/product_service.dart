import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:pizza_order/views/product/logic/product.dart';

import '../../../routes/endpoint-rest-api.dart';

class ProductServices {
  Future<void> create(Product t) async {
    final response = await post(
      Uri.parse(Endpoint.apiProduct),
      headers: Endpoint.$httpHeader,
      body: jsonEncode(t.toJson()),
    );

    if (response.statusCode == 201) {
      log('Product created successfully!');
    } else {
      throw Exception(
          'Failed to create product. Error: ${response.statusCode}');
    }
  }

  Future<List<Product>?> read() async {
    final response = await get(
      Uri.parse(Endpoint.apiProduct),
      headers: Endpoint.$httpHeader,
    );
    print("RESULT");
    print(response);
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Products');
    }
  }


  Future<void> update(Product t) async {
    final response = await put(
      Uri.parse('${Endpoint.apiProduct}/${t.id}'),
      headers: Endpoint.$httpHeader,
      body: jsonEncode(t.toJson()),
    );

    if (response.statusCode == 200) {
      log('Product updated successfully!');
    } else {
      throw Exception(
          'Failed to update customer. Error: ${response.statusCode}');
    }
  }

  Future<void> remove(String id) async {
    final url = Uri.parse('${Endpoint.apiProduct}/$id');
    final response = await delete(url);

    if (response.statusCode == 200) {
      log('Product deleted successfully!');
    } else {
      throw Exception(
          'Failed to delete product. Error: ${response.statusCode}');
    }
  }
}