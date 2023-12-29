import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/routes/route_name.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Delivery Order'),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Image.asset('assets/images/pizza-delivery.png'),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                _cardButton(
                  $pressProduct,
                  Icons.cases_sharp,
                  Colors.amber,
                  'Products',
                ),
                _cardButton(
                  $pressOrder,
                  Icons.add_business,
                  Colors.blueGrey,
                  'Order',
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                _cardButton(
                  $pressCustomer,
                  Icons.account_box_sharp,
                  Colors.green,
                  'Customer',
                ),
                _cardButton(
                  $pressCart,
                  Icons.shopping_cart,
                  Colors.red,
                  'Cart',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void $pressProduct() {
    Get.toNamed(RouteName.productsPage);
  }

  void $pressOrder() {
    Get.toNamed(RouteName.itemsPage);
  }

  void $pressCustomer() {
    Get.toNamed(RouteName.customerPage);
  }

  void $pressCart() {
    Get.offAllNamed(RouteName.orderCreate);
  }

  Widget _cardButton(
    void Function() onPressButton,
    IconData icon,
    Color iconColor,
    String title,
  ) =>
      Expanded(
        child: Card(
          color: Colors.white,
          child: TextButton(
            onPressed: onPressButton,
            child: Column(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
}

BoxDecoration ___boxDecor() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 4,
        offset: const Offset(0, 2), // Geser bayangan horizontal dan vertikal
      ),
    ],
  );
}
// List Tile silahkan tambahkan
// leading: CircleAvatar(
// backgroundImage: AssetImage('assets/image.jpg'),
// ),
