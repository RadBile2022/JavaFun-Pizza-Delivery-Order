import 'package:pizza_order/views/product/product_detail.dart';
import 'package:pizza_order/routes/route_name.dart';
import 'package:pizza_order/views/customer/customer_create.dart';
import 'package:pizza_order/views/customer/customer_edit.dart';
import 'package:pizza_order/views/customer/customer_list.dart';
import 'package:pizza_order/views/order/order_create.dart';
import 'package:pizza_order/views/order/order_detail.dart';
import 'package:pizza_order/views/order/order_list.dart';
import 'package:pizza_order/views/product/product_create.dart';
import 'package:pizza_order/views/product/product_edit.dart';
import 'package:pizza_order/views/product/product_list.dart';
import 'package:pizza_order/views/splash_screen.dart';
import 'package:pizza_order/views/tab/account.dart';
import 'package:pizza_order/views/tab/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/order/items.dart';
import '../views/order/order_customer-order.dart';
import '../views/tab/tab-nav-bar.dart';

class PageRouteApp {
  static final pages = [
    GetPage(name: RouteName.splash, page: ()=>SplashScreen()),
    GetPage(name: RouteName.tabNavBar, page: ()=> TabNavBars()),
    GetPage(name: RouteName.dashboard, page: ()=> Home()),
    // GetPage(name: RouteName.history, page: ()=> const ),
    GetPage(name: RouteName.account, page: ()=> Account()),
    //
    GetPage(name: RouteName.productsPage, page: ()=> ProductListPage()),
    GetPage(name: RouteName.productCreate, page: ()=> ProductCreatePage() ),
    GetPage(name: RouteName.productDetail, page: ()=> ProductDetailPage() ),
    GetPage(name: RouteName.productEdit, page: ()=> ProductEditPage() ),
    //
    GetPage(name: RouteName.orderPage, page: ()=> OrderListPage()),
    GetPage(name:RouteName.itemsPage, page: ()=> ItemsCartPage()),
    GetPage(name: RouteName.orderCreate, page: ()=> OrderCreatePage() ),
    GetPage(name: RouteName.customerOrder, page: ()=> OrderCustomerList() ),
    GetPage(name: RouteName.orderEdit, page: ()=> OrderDetailPage()),
    //
    GetPage(name: RouteName.customerPage, page: ()=> CustomerListPage()),
    GetPage(name: RouteName.customerCreate, page: ()=> CustomerCreatePage()),
    GetPage(name: RouteName.customerEdit, page: ()=> CustomerEditPage()),
  ];
}