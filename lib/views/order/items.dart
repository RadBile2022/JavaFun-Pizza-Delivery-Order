import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/routes/route_name.dart';

import '../product/ProductController.dart';
import '../product/logic/product.dart';
import '../product/logic/product_contoller.dart';
import '../tab/Tab-Nav-Controller.dart';
import 'ItemsController.dart';

class ItemsCartPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final pmController = Get.find<PMController>();
  final itemController = Get.find<ItemController>();
  final tabController = Get.find<TabControllers>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Order'),
        leading: IconButton(
          onPressed: $onTapBack,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        children: List.generate(pmController.productList.length, (index) {
          Product p = pmController.productList[index];
          return Card(
            child: TextButton(
              onPressed: () => $showModal(context, p),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Image.network(
                      p.imageNetwork,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    p.name.toString(),
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text('\$ ${p.iconPrice.toString()}'),
                ],
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(
        () => itemController.isFloatingActionButtonVisible.value
            ? $bottomSizedBox(itemController.items.length.toString(),
                itemController.total.value.toStringAsFixed(2))
            : const Padding(padding: EdgeInsets.zero),
      ),
    );
  }

  void $onTapBack() {
    tabController.changeTab(0);
    Get.offAllNamed(RouteName.tabNavBar);
  }

  void $showModal(BuildContext context, Product p) {
    var inputQty = TextEditingController();
    Item? currentItem = itemController.findItemByProductId(p.id!);

    if (currentItem != null) {
      inputQty.text = currentItem.qty.toString();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Beli ${p.name}, Berapa ?'),
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
              child:  const Text('Cancel', style: TextStyle(color: Colors.white),),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (currentItem?.qty == null) {
                    var item = Item(product: p, qty: int.parse(inputQty.text));
                    itemController.addItem(item);

                  } else {
                    currentItem!.qty = int.parse(inputQty.text);
                    /*** This is for delete item in New Order Page ***/
                    if(currentItem.qty <=0 ){
                      itemController.deleteItem(currentItem!);
                    }
                  }
                  itemController.updateFloatingActionButtonVisibility();
                  Get.back();
                }
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  SizedBox $bottomSizedBox(String itemCount, String totalAmount) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue),
      child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),

        onPressed: () {
          Get.toNamed(RouteName.orderCreate);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(itemCount,style: TextStyle(color: Colors.white),),
            Text('\$ $totalAmount',style: TextStyle(color: Colors.white),),
          ],
        ),
      ),),

    );
  }
}

String rujakBuah =
    "https://rinaresep.com/wp-content/uploads/2021/12/rujak-buah.jpg";
String sotoAyam =
    'https://assets.ayobandung.com/crop/0x0:0x0/750x500/webp/photo/2023/01/16/2155155208.jpg';
String pecelBlitar =
    'https://asset.kompas.com/crops/etxkCgz_0N5ZbdP6YGJScpobPVk=/60x23:959x622/750x500/data/photo/2020/11/05/5fa3f16d9c1cf.jpg';

void px(BuildContext context) {
  String px =
      ' ${MediaQuery.of(context).size.width.toString().substring(0, 5)} px';
}

//   return TourismPlaceList();
// }else if(contraints.maxWidth <=1200){
//   return TourismPlaceGrid(gridCount: 4);
// } else{
//   return TourismPlaceGrid(gridCount: 6);
// }
