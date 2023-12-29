import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/views/order/OrderController.dart';
import 'package:pizza_order/routes/route_name.dart';

import '../tab/Tab-Nav-Controller.dart';

class OrderListPage extends StatelessWidget {
  final tabController = Get.find<TabControllers>();
  final omController = Get.find<OMController>();

  OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      backgroundColor: Colors.grey[200],
      body:
          GetBuilder<OMController>(
            builder: (omController) =>
          ListView.builder(
        padding: const EdgeInsets.only(bottom: 90, top: 15),
        itemCount: omController.orderList.length,
        itemBuilder: (context, index) {
          Order o = omController.orderList[index];
          return InkWell(
            onTap: () => $onTapList(o.id),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              // shape: RoundedRectangleBorder(
              //   borderRadius:
              //       BorderRadius.circular(0), // Menghilangkan rounded corners
              // ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(o.id!.toUpperCase()),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey[400],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pembeli',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              o.customer.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                Text(
                                  ' ${o.currentDate.substring(0, 16)}',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Text(
                            '\$ ${o.$getTotal().toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),

                        // Padding(padding: EdgeInsets.only(right: 25),  child:                  ,),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('${o.$getQty().toString()} Item'),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Text(
                        'Sukses',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2.0,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                title: Row(
                  children: [
                    const Text(
                      'Customer : ',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      o.customer!.name.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.green),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    const Text(
                      'Total Amount : ',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '\$ ${o.$getTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.indigo),
                    ),
                  ],
                ),
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
                onTap: () => $onTapList(o.id),
                onLongPress: () => $onLongPressList(o.id),
              ),
            ),
          );
        },
      ),),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => $onTapAdd(),
        child: Icon(Icons.add,color: Colors.white),
        backgroundColor: Colors.red,
      ),
    );
  }

  void $onTapBack() {
    tabController.changeTab(0);
    Get.toNamed(RouteName.tabNavBar);
  }

  void $onTapAdd() {
    Get.toNamed(RouteName.itemsPage);
  }

  void $onTapList(dynamic args) {
    Get.toNamed(RouteName.orderEdit, arguments: args);
  }

  void $onLongPressList(dynamic args) {
    Get.toNamed(RouteName.orderEdit, arguments: args);
  }
}
