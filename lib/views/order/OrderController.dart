import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../customer/CustomerController.dart';
import '../../routes/endpoint-rest-api.dart';
import 'ItemsController.dart';

class Order extends GetxController {
  String? id;
  String currentDate;
  Customer customer;
  List items = <Item>[].obs;

  Order({
    this.id,
    required this.currentDate,
    required this.customer,
    required List<dynamic> items,
  }) : items = items ?? [];

  double $getTotal() {
    double total = 0;
    for (Item item in items) {
      total += item.$subTotal();
    }
    update();
    return total;
  }
  int $getQty() {
    int qtyAll = 0;
    for (Item item in items) {
      qtyAll += item.qty;
    }
    update();
    return qtyAll;
  }

  @override
  String toString() {
    return 'Order{id: $id, customer: $customer, _items: $items}';
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      currentDate: json['dateNow'],
      customer: Customer.fromJson(json['customer']),
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateNow' : currentDate,
      'customer': customer?.toJson(),
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class OMController extends GetxController {
  List orderList = <Order>[].obs;
  var service = OrderService();

  @override
  void onInit() {
    readData();
    super.onInit();
  }

  readData() async {
    List<Order>? result = await service.read();
    if (result != null) {
      update();
      orderList.assignAll(result);
    } else {
      print('null');
    }
    update();
  }

  void addOrder(Order t) async {
    orderList.add(t);
    await service.create(t);
    readData();
  }

  Order? findOrderById(String id) {
    for (Order o in orderList) {
      if (o.id == id) {
        return o;
      }
    }
    return null;
  }

  void updateOrder(Order t) async {
    await service.update(t);
  }

  void deleteOrder(Order t) async {
    orderList.remove(t);
    service.remove(t.id!);
  }
}

class OrderService {
  Future<void> create(Order t) async {
    final response = await post(
      Uri.parse(Endpoint.apiOrder),
      headers: Endpoint.$httpHeader,
      body: jsonEncode(t.toJson()),
    );

    if (response.statusCode == 200) {
      print('Order created successfully!');
    } else {
      throw Exception(
          'Failed to create Order. Error: ${response.statusCode}');
    }
  }

  Future<List<Order>?> read() async {
    final response = await get(
      Uri.parse(Endpoint.apiOrder),
      headers: Endpoint.$httpHeader,
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => Order.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Order');
    }
  }

  Future<void> update(Order t) async {
    final response = await put(
      Uri.parse('${Endpoint.apiOrder}/${t.id}'),
      headers: Endpoint.$httpHeader,
      body: jsonEncode(t.toJson()),
    );

    if (response.statusCode == 200) {
      print('Order updated successfully!');
    } else {
      throw Exception(
          'Failed to update Order. Error: ${response.statusCode}');
    }
  }

  Future<void> remove(String id) async {
    final url = Uri.parse('${Endpoint.apiOrder}/$id');
    final response = await delete(url);

    if (response.statusCode == 200) {
      print('Order deleted successfully!');
    } else {
      throw Exception(
          'Failed to delete Order. Error: ${response.statusCode}');
    }
  }
}
