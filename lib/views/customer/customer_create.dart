import 'package:pizza_order/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CustomerController.dart';

class CustomerCreatePage extends StatelessWidget {
  final customerController = Get.find<CMController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  CustomerCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Create'),

      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: ()=>$submitForm(),
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> $submitForm() async{
    final name = nameController.text;
    final address = addressController.text;
    final phone = phoneController.text;

    final newCustomer = Customer(name: name, address: address, phone: phone);
    customerController.addCustomer(newCustomer);
    await customerController.readData();
/***
 Kalau Get.back() doang, harus pagenya dikasih Obx(()=>) agar merender ulang
 ***/
   Get.back();

  }
}
