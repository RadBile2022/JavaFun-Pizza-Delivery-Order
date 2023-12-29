import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/routes/route_name.dart';

import 'ProductController.dart';
import '../tab/Tab-Nav-Controller.dart';
import 'logic/product.dart';
import 'logic/product_contoller.dart';

class ProductListPage extends StatelessWidget {
  final tabController = Get.find<TabControllers>();
  final pmController = Get.find<PMController>();

  ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: $onTapBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Product List'),
      ),
      backgroundColor: Colors.grey[100],
      body:ListView.builder(
        itemCount: pmController.productList.length,
        padding: const EdgeInsets.only(bottom: 90,top:12),
        itemBuilder: (context, index) {
          final Product p = pmController.productList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2.0,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: NetworkImage(p.imageNetwork)),
                  ),
                  // Gambar produk di sini
                ),
                title: Text(
                  p.name,
                ),
                subtitle: Text(
                  p.category,
                  // style: Theme.of(context).textTheme.subtitle2,
                ),
                onTap: () => $onTapList(context, p.id),
              ),
            ),
          );
        },
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: $onTapAdd,
        backgroundColor: Colors.red[600],
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  // void $onTapDetail (){
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return DetailScreen(
  //         p: p,index: index,
  //       );
  //     }),
  //   );
  // }

  // void $onPressedAdd (){
  //   Navigator.push(context, MaterialPageRoute(builder: (context){
  //     return CreateScreen();
  //   }));
  // }
  //

  void $onTapBack() {
    tabController.changeTab(0);
    Get.offAllNamed(RouteName.tabNavBar);
  }

  void $onTapAdd() {
    Get.toNamed(RouteName.productCreate);
  }

  void $onTapList(BuildContext context, dynamic args) {
    Get.toNamed(RouteName.productDetail, arguments: args);
  }

  void $onLongPressList(dynamic args) {
    // Get.toNamed(RouteName.productEdit, arguments: args);
  }
}
