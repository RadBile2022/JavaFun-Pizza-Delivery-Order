import 'package:pizza_order/views/order/order_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../order/ItemsController.dart';
import '../order/OrderController.dart';
import '../customer/CustomerController.dart';
import '../product/ProductController.dart';
import '../product/logic/product_contoller.dart';
import 'Tab-Nav-Controller.dart';
import 'home.dart';

class TabNavBars extends StatelessWidget {
  final tabController = Get.put(TabControllers());
  final cmController = Get.put(CMController());
  final pmController = Get.put(PMController());
  final omController = Get.put(OMController());
  // final orderController = Get.put(Order());
  final itemController = Get.put(ItemController());

  TabNavBars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: tabController.currentIndex.value,
          children: [
             Home(),
          OrderListPage(),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: tabController.currentIndex.value,
          onTap: tabController.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell_outlined),
              label: 'Riwayat Transaksi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Saya',
            ),
          ],
        ),
      ),
    );
  }
}
// Home(),
// OrderListPage(),
// CustomerListPage(),
// Account()

// BottomNavigationBarItem(
//   icon: Icon(Icons.person),
//   label: 'Tab 3',
// ),