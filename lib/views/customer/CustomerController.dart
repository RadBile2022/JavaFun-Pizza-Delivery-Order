import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:pizza_order/routes/endpoint-rest-api.dart';

class CMController extends GetxController {
  List customerList = <Customer>[].obs;
  var service = CustomerService();

  @override
  void onInit() {
    readData();
    super.onInit();
  }

  Future<void> readData() async {
    List<Customer>? result = await service.read();
    if (result != null) {
      print('server is not empty');
      customerList.assignAll(result);
      update();

    } else {
      print('server null');
      // customerList.assignAll(products);
    }
    update();
  }

  void addCustomer(Customer t) async {
    customerList.add(t);
    await service.create(t);
  }

  Customer? findCustomerById(String? id) {
    for (Customer c in customerList) {
      if (c.id == id) {
        return c;
      }
    }
    return null;
  }

  void updateCustomer(Customer t) async {
    await service.update(t);
  }

  void deleteCustomer(Customer t) async {
    customerList.remove(t);
    service.remove(t.id!);
  }
}

class Customer {
  String? id;
  String name;
  String address;
  String phone;

  Customer({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
  });

  @override
  String toString() {
    return 'Customer{id: $id, name: $name, address: $address, phone: $phone}';
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
    };
  }
}

class CustomerService {
  Future<void> create(Customer t) async {
    final response = await post(
      Uri.parse(Endpoint.apiCustomer),
      headers: Endpoint.$httpHeader,
      body: jsonEncode(t.toJson()),
    );

    if (response.statusCode == 201) {
      print('Customer created successfully!');
    } else {
      throw Exception(
          'Failed to create Customer. Error: ${response.statusCode}');
    }
  }

  Future<List<Customer>?> read() async {
    final response = await get(
      Uri.parse(Endpoint.apiCustomer),
      headers: Endpoint.$httpHeader,
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => Customer.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Customers');
    }
  }

  Future<void> update(Customer t) async {
    final response = await put(
      Uri.parse('${Endpoint.apiCustomer}/${t.id}'),
      headers: Endpoint.$httpHeader,
      body: jsonEncode(t.toJson()),
    );

    if (response.statusCode == 200) {
      print('Customer updated successfully!');
    } else {
      throw Exception(
          'Failed to update customer. Error: ${response.statusCode}');
    }
  }

  Future<void> remove(String id) async {
    final url = Uri.parse('${Endpoint.apiCustomer}/$id');
    final response = await delete(url);

    if (response.statusCode == 200) {
      print('Customer deleted successfully!');
    } else {
      throw Exception(
          'Failed to delete Customer. Error: ${response.statusCode}');
    }
  }
}
