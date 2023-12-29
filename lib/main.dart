import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/routes/page_routes.dart';
import 'package:pizza_order/views/splash_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pizza Delivery',
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.blueAccent),
      ),
      home: SplashScreen(),
      getPages: PageRouteApp.pages,
    );
  }
}