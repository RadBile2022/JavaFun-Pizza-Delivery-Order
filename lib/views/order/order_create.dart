import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/views/customer/CustomerController.dart';
import 'package:pizza_order/routes/route_name.dart';

import 'ItemsController.dart';
import 'OrderController.dart';
import '../tab/Tab-Nav-Controller.dart';

class OrderCreatePage extends StatelessWidget {
  final itemController = Get.find<ItemController>();
  final cmController = Get.find<CMController>();
  final omController = Get.find<OMController>();
  final tabController = Get.find<TabControllers>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String? idCustomer = Get.arguments;
  late Customer? c = cmController.findCustomerById(idCustomer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Shop'),
        leading: IconButton(
          onPressed: $onTapBack,
          icon: const Icon(Icons.add_business),
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
                c == null
                    ? const Text('Customer :')
                    : Row(
                        children: [
                          const Text('Customer :  '),
                          Text(
                            c!.name.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                Obx(
                  () => itemController.items.isEmpty
                      ? const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.account_box,
                          ),
                        )
                      : CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              Get.toNamed(RouteName.customerOrder);
                            },
                            icon: const Icon(
                              Icons.account_box,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: itemController.items.length,
                itemBuilder: (context, index) {
                  Item item = itemController.items[index];
                  return ListTile(
                    onTap: () => $showModal(context, item),
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
                    subtitle: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$ ${item.product.iconPrice}'),
                          Row(
                            children: [
                              Text(
                                item.qtyObs.value.toString(),
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
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        itemController.deleteItem(item);
                        itemController.updateFloatingActionButtonVisibility();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemController.items.isEmpty
                  ? Row(
                      children: [
                        const Text('Grand Total : '),
                        Text(
                          '\$ ${itemController.total.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const Text('Grand Total : '),
                        Text(
                          '\$ ${itemController.total.value.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
              ElevatedButton(
                onPressed: c == null || itemController.items.isEmpty
                    ? null
                    : () async{
                      DateTime dateNow = DateTime.now();
                        var order = Order(
                          currentDate: dateNow.toString(),
                          customer: c!,
                          items: itemController.items,
                        );
                        omController.addOrder(order);

                        // omController.update();
                        await omController.readData();

                        itemController.items.clear();
                        itemController.total;
                        itemController.updateFloatingActionButtonVisibility();
                        tabController.currentIndex.value = 1;
                        Get.offAllNamed(RouteName.tabNavBar);
                      },
                child: const Text('Pay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void $onTapBack() {
    Get.offNamed(RouteName.itemsPage);
  }

  void $showModal(BuildContext context, Item currentItem) {
    var inputQty = TextEditingController();
    // Item? currentItem = itemController.findItemByProductId(idItem);
    // Item? currentItem = itemController.findItemById(idItem);

    inputQty.text = currentItem!.qty.toString();
    //
    // if (currentItem != null) {
    //   inputQty.text = currentItem.qty.toString();
    // }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Beli ${currentItem.product.name}, Berapa ?'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: inputQty,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Masukkan qty ...',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text('Cancel',style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  currentItem.qty = int.parse(inputQty.text);
                  if (currentItem.qty <= 0) {
                    itemController.deleteItem(currentItem);
                  }
                  itemController.updateFloatingActionButtonVisibility();
                  Get.back();

                  //   currentItem!.qty = int.parse(inputQty.text);
                  //   /*** This is for delete item in New Order Page ***/
                  //   if(currentItem.qty <=0 ){
                  //     itemController.deleteItem(currentItem!);
                  //   }
                  // }
                  // itemController.updateFloatingActionButtonVisibility();
                  // Get.back();

                  // itemController.deleteItem(item);
                  // itemController.updateFloatingActionButtonVisibility();

                  // if (currentItem?.qty == null) {
                  //   var item = Item(product: p, qty: int.parse(inputQty.text));
                  //   itemController.addItem(item);
                  // } else {
                  //   currentItem!.qty = int.parse(inputQty.text);
                  //   /*** This is for delete item in New Order Page ***/
                  //   if(currentItem.qty <=0 ){
                  //     itemController.deleteItem(currentItem!);
                  //   }
                  // }
                  // itemController.updateFloatingActionButtonVisibility();
                  // Get.back();
                }
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void $onTap(BuildContext context, dynamic args) {
    var inputQty = TextEditingController();
    _showModal(context, inputQty, args);
  }

  void _showModal(
      BuildContext context, TextEditingController inputQty, int args) {
    var item = itemController.findItemById(args);

    inputQty.text = item!.qty.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Beli ${item.product!.name}, Berapa ?'),
          content: TextField(
            controller: inputQty,
            decoration: const InputDecoration(
              hintText: 'Masukkan qty...',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
                child: Text('Lanjut'),
                onPressed: () {
                  item.qty = int.parse(inputQty.text);
                  if (item.qty == 0) {
                    itemController.deleteItem(item);
                    itemController.total.value = itemController.$getTotal();
                    itemController.updateFloatingActionButtonVisibility();

                    Get.back();
                  } else {
                    itemController.total.value = itemController.$getTotal();

                    itemController.update();
                    Get.back();
                  }
                }),
          ],
        );
      },
    );
  }
}

// automaticallyImplyLeading: true,
// class dummy {
//   void main () {
//     Container(
//       padding: EdgeInsets.all(16),
//       color: Colors.grey[200],
//       child: Row(
//         children: [
//           Expanded(
//             child: c == null
//                 ? Text('Pelanggan:')
//                 : Row(
//               children: [
//                 Text('Pelanggan: '),
//                 Text(
//                   c!.name.toString(),
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green),
//                 )
//               ],
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.toNamed(RouteName.customerPage);
//             },
//             child: Text('Tambah Pelanggan'),
//           ),
//         ],
//       ),
//     ),
//
//   }
//
//   void mainnn(){
//     Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 2,
//             offset: Offset(0, -1),
//           ),
//         ],
//       ),
//       child: Obx(
//             () => Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             RichText(
//               text: TextSpan(
//                 text: 'Total: ',
//                 style: TextStyle(fontSize: 16, color: Colors.black),
//                 children: [
//                   TextSpan(
//                     text:
//                     '\$ ${itemController.$getTotal().toStringAsFixed(2)}',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ),
//             ElevatedButton(
//               child: Text('Pembayaran'),
//               onPressed: c == null || itemController.items.isEmpty
//                   ? null
//                   : () {
//                 var order = Order();
//                 order.customer = c;
//                 order.setItems(itemController.items);
//                 omController.addOrder(order);
//
//                 omController.update();
//                 omController.readData();
//                 itemController.items.clear();
//                 itemController.total;
//                 itemController.updateFloatingActionButtonVisibility();
//
//                 tabController.currentIndex.value = 1;
//                 Get.offNamed(RouteName.tabNavBar);
//               },
//             ),
//           ],
//         ),
//       ),
//     ),
//
//   }
// }
