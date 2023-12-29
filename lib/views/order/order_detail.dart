import 'package:pizza_order/views/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../tab/Tab-Nav-Controller.dart';
import 'ItemsController.dart';
import 'OrderController.dart';
import '../../routes/route_name.dart';

class OrderDetailPage extends StatelessWidget {
  final tabController = Get.find<TabControllers>();

  final omController = Get.find<OMController>();
  final idOrder = Get.arguments;
  late Order? o = omController.findOrderById(idOrder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Order : ${o!.id!.toUpperCase()}'),
        leading: IconButton(
          onPressed: $onTapBack,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Customer :  '),
                    Text(
                      o!.customer.name.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: o!.items.length,
              itemBuilder: (context, index) {
                Item item = o!.items[index];
                return ListTile(
                  onTap: null,
                  leading: Image.network(
                    item.product.imageNetwork,
                    width: 60,
                    height: 60,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.product.name),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$ ${item.product.iconPrice}'),
                      Row(
                        children: [
                          Text(
                            item.qty.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(' pcs'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '\$ ${item.$subTotal().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // trailing: IconButton(
                  //   icon: const Icon(Icons.remove_circle, color: Colors.red),
                  //   onPressed: () {
                  //     itemController.deleteItem(item);
                  //     itemController.updateFloatingActionButtonVisibility();
                  //   },
                  // ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialogBox(
          context,
          'Order',
          'Order-${o!.id}',
          $onPressedDeleted,
        ),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.redAccent,
          size: 30,
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('Grand Total : '),
                Text(
                  '\$ ${o!.$getTotal().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void $onPressedDeleted() {
    omController.deleteOrder(o!);
    tabController.currentIndex.value = 1;
    Get.offAllNamed(RouteName.tabNavBar);
  }

  void $onTapBack() {
    tabController.currentIndex.value = 1;
    Get.offAllNamed(RouteName.tabNavBar);
  }
}
//
// bottomNavigationBar: Container(
// height: 45,
// child: ElevatedButton(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text('Total \$ ${widget.parent!.order!.getTotal()}'),
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Text(' Check Out Order '),
// Icon(Icons.arrow_right_sharp)
// ],
// )
// ],
// ),
// onPressed: () {
// widget.parent!.omController!.addOrder(widget.parent!.order!);
// Navigator.push(context, MaterialPageRoute(builder: (context) {
// widget.parent!.selectedIndex = 1;
// return TabBars.parent(widget.parent!);
// }));
//
// // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TabBars.parent(widget.parent!)));
// },
// ),
// ),
