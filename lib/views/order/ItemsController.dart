import 'package:get/get.dart';

import '../product/ProductController.dart';
import '../product/logic/product.dart';

class Item extends GetxController {
  int id = 0;
  Product product;
  int qty;
  RxInt qtyObs=0.obs ;
  //
  Item({required this.product, required this.qty}) : id = _idCounter++;
  static int _idCounter = 1;

  double $subTotal() {
    /***
     kalau qtyObs = qty.obs tidak akan merender
     yang dirender adalah qtyObs.value OKE
     ***/
    qtyObs.value = qty;
    double sub = product.iconPrice * qtyObs.value;
    update();
    return sub;
  }

  @override
  String toString() {
    return 'Item{id: $id, product: $product, qty: $qty}';
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      // id: json['id'],
      product: Product.fromJson(json['product']),
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'product': product.toJson(),
      'qty': qty,
    };
  }
}

class ItemController extends GetxController {
  late RxDouble total = $getTotal().obs;
  List items = <Item>[].obs;

  void addItem(Item item) {
    items.add(item);
  }

  Item? findItemById(int id) {
    for (Item item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  Item? findItemByProductId(String id) {
    for (Item item in items) {
      if (item.product!.id == id) {
        return item;
      }
    }
    return null;
  }

  void deleteItem(Item item) {
    items.remove(item);
  }

  var isFloatingActionButtonVisible = false.obs;

  void updateFloatingActionButtonVisibility() {
    if (items.isNotEmpty) {
      total.value = $getTotal();
      isFloatingActionButtonVisible.value = true;
    } else {
      total.value = $getTotal();
      isFloatingActionButtonVisible.value = false;
    }
  }

  @override
  void onInit() {
    update();
    super.onInit();
  }

  int $getQty() {
    int qty = 0;
    for (Item item in items) {
      qty += item.qty!;
    }
    return qty;
  }

  double $getTotal() {
    double total = 0;
    for (Item item in items) {
      total += item.$subTotal();
    }
    update();
    return total;
  }
}
