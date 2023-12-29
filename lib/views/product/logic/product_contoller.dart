import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pizza_order/views/product/logic/product.dart';
import 'package:pizza_order/views/product/logic/product_service.dart';

class PMController extends GetxController {
  List productList = <Product>[].obs;
  var service = ProductServices();
  var postLoading = true.obs;


  @override
  void onInit() {
    readData();
    super.onInit();
  }

  Future<void> readData() async {
    List<Product>? result = await service.read();
    if (result != null) {
      productList.assignAll(result);
      update();

    } else {
      throw ('server null');
    }
    update();
  }

  void addProduct(Product t) async {
    productList.add(t);
    await service.create(t);
  }

  Product? findProductById(String id) {
    for (Product p in productList) {
      if (p.id == id) {
        return p;
      }
    }
    return null;
  }

  void updateProduct(Product t) async {
    await service.update(t);
  }

  void deleteProduct(Product t) async {
    productList.remove(t);
    service.remove(t.id!);
  }
}