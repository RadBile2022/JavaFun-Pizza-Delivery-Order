import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/routes/route_name.dart';

import '../customer/CustomerController.dart';
import '../tab/Tab-Nav-Controller.dart';

class OrderCustomerList extends StatelessWidget {
  final tabController = Get.find<TabControllers>();
  final cmController = Get.find<CMController>();

  OrderCustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Customer Please'),
        leading: IconButton(
          onPressed: $onTapBack,
          icon: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        itemCount: cmController.customerList.length,
        padding: const EdgeInsets.only(bottom: 90, top: 12),
        itemBuilder: (context, index) {
          final Customer c = cmController.customerList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2.0,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: const CircleAvatar(child: Icon(Icons.account_box)),
                title: Text(
                  c.name,
                ),
                subtitle: Text(
                  c.address,
                  // style: Theme.of(context).textTheme.subtitle2,
                ),
                onTap: () => $onTapList(c.id.toString()),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => $onPressedAdd(),
        backgroundColor: Colors.red[700],
        child: const Icon(Icons.add),
      ),
    );
  }

  void $onTapBack() {
    Get.offAllNamed(RouteName.orderCreate);
  }

  void $onPressedAdd() {
    Get.toNamed(RouteName.customerCreate);
  }

  void $onTapList(String id) {
    Get.toNamed(RouteName.orderCreate, arguments: id);
  }
}

// void $onLongPressList(dynamic id) {
//   // Get.offNamed(RouteName.orderCreate, arguments: id);
//   Get.toNamed(RouteName.customerEdit, arguments: id);
// }
