import 'package:pizza_order/views/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/routes/route_name.dart';

import 'CustomerController.dart';

class CustomerEditPage extends StatelessWidget {
  final cmController = Get.find<CMController>();
  final idCustomer = Get.arguments;
  late Customer? c = cmController.findCustomerById(idCustomer);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  CustomerEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    nameController.text = c!.name!;
    addressController.text = c!.address!;
    phoneController.text = c!.phone!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Edit'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => showDialogBox(
                        context,
                        'Customer',
                        c!.name,
                        $onPressedDeleted,
                      ),
                      child: const Text('Delete',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => $submitForm(),
                    child: Text('Update'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void $onPressedDeleted() {
    cmController.deleteCustomer(c!);
    Get.offAllNamed(RouteName.customerPage);
  }

  void $submitForm() {
    final name = nameController.text;
    final address = addressController.text;
    final phone = phoneController.text;

    c!.name = name;
    c!.address = address;
    c!.phone = phone;

    cmController.updateCustomer(c!);
    /***
        Kalau memakai Get.back(), niscaya anda tidak merender ulang page, jelas.
     ***/
    Get.offAllNamed(RouteName.customerPage);
  }
}
