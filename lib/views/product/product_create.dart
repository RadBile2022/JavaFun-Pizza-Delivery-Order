
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_order/views/product/ProductController.dart';
import 'package:pizza_order/routes/route_name.dart';

import '../customer/CustomerController.dart';
import 'logic/product.dart';
import 'logic/product_contoller.dart';

class ProductCreatePage extends StatelessWidget {


  final TextEditingController imgNetworkCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController prepCtrl = TextEditingController();
  final TextEditingController cookCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController bonus1a = TextEditingController();
  final TextEditingController bonus1b = TextEditingController();
  final TextEditingController bonus2a = TextEditingController();
  final TextEditingController bonus2b = TextEditingController();
  final TextEditingController bonus3a = TextEditingController();
  final TextEditingController bonus3b = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pmController = Get.find<PMController>();




 Future <void> $submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
        var value = Product(
          imageNetwork: imgNetworkCtrl.text,
          name: nameCtrl.text.toUpperCase(),
          category: categoryCtrl.text,
          desc: descCtrl.text,
          iconPrep: prepCtrl.text,
          iconCook: cookCtrl.text,
          iconPrice: double.parse(priceCtrl.text),
          bonusBundling: [
            BonusBundling(
              title: bonus1a.text,
              image: bonus1b.text,
            ),
            BonusBundling(
              title: bonus2a.text,
              image: bonus2b.text,
            ),
            BonusBundling(
              title: bonus3a.text,
              image: bonus3b.text,
            ),
          ]

        );

        pmController.addProduct(value);
        await pmController.readData();
        Get.offAllNamed(RouteName.productsPage);

        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) {
        //   return ListScreen();
        // }));
    }
  }
  @override
  Widget build(BuildContext context) {
    var p = Product(
      imageNetwork: 'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689844331106.png',
      name: 'SOUP OF THE DAY',
      category: '',
      desc: 'Sup Spesial Harian',
      iconPrep: '10',
      iconCook: '15',
      iconPrice: 86,
      bonusBundling: [
        BonusBundling(
          title: 'CUMI CABE IJO',
          image:
          'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689843644814.png',
        ),
        BonusBundling(
          title: 'CREAMY TRUFFLE',
          image:
          'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689843649983.png',
        ),
        BonusBundling(
          title: 'LYCHEE BREEZE',
          image:
          'https://api-portfolio.gft.academy/storage/images/fileAlbum_1689843907219.png',
        ),
      ],
    );

    imgNetworkCtrl.text = p.imageNetwork;
    nameCtrl.text = p.name;
    categoryCtrl.text = p.category;
    // categoryCtrl.clear();
    descCtrl.text = p.desc;
    prepCtrl.text = p.iconPrep;
    cookCtrl.text = p.iconCook;
    priceCtrl.text = p.iconPrice.toString();
    bonus1a.text = p.bonusBundling[0].title;
    bonus1b.text = p.bonusBundling[0].image;
    bonus2a.text = p.bonusBundling[1].title;
    bonus2b.text = p.bonusBundling[1].image;
    bonus3a.text = p.bonusBundling[2].title;
    bonus3b.text = p.bonusBundling[2].image;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Create'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                textFormField(
                  controller: imgNetworkCtrl,
                  labelText: 'Image Asset',
                ),
                textFormField(
                  controller: nameCtrl,
                  labelText: 'Name Product',
                ),
                textFormField(
                  controller: categoryCtrl,
                  labelText: 'Category Product',
                ),
                textFormField(
                  controller: descCtrl,
                  labelText: 'Description Product',
                  minLines: 2,
                  maxLines: null,
                ),
                textFormField(
                  controller: prepCtrl,
                  labelText: 'Preparation Time',
                  keyboardType: TextInputType.number,
                ),
                textFormField(
                  controller: cookCtrl,
                  labelText: 'Cook Time',
                  keyboardType: TextInputType.number,
                ),
                textFormField(
                  controller: priceCtrl,
                  labelText: 'Price Product',
                  keyboardType: TextInputType.number,
                ),
                Container(
                  color: Colors.grey,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Text('Bonus Bundling',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                TextField(
                  controller: bonus1a,
                  decoration: const InputDecoration(
                    labelText: 'Title Image Bonus 1',
                  ),
                ),
                TextField(
                  controller: bonus1b,
                  decoration: const InputDecoration(
                    labelText: ' Image Bonus 1',
                  ),
                ),
                TextField(
                  controller: bonus2a,
                  decoration: const InputDecoration(
                    labelText: 'Title Image Bonus 2',
                  ),
                ),
                TextField(
                  controller: bonus2b,
                  decoration: const InputDecoration(
                    labelText: ' Image Bonus 2',
                  ),
                ),
                TextField(
                  controller: bonus3a,
                  decoration: const InputDecoration(
                    labelText: 'Title Image Bonus 3',
                  ),
                ),
                TextField(
                  controller: bonus3b,
                  decoration: const InputDecoration(
                    labelText: ' Image Bonus 3',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => $submitForm(context),
                  child: const Text('Create Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    int? minLines,
    int? maxLines,
  }) =>
      Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            minLines: minLines,
            maxLines: maxLines,
            decoration: InputDecoration(
              labelText: labelText,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
        ],
      );



  // final TextEditingController idController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController priceController = TextEditingController();
  //
  // ProductCreatePage({super.key});
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Product Create'),
  //
  //     ),
  //     body: SafeArea(
  //       child: Padding(
  //         padding: EdgeInsets.all(30),
  //         child: Column(
  //           children: [
  //             TextField(
  //               controller: idController,
  //               decoration: InputDecoration(
  //                 hintText: 'What id',
  //                 labelText: 'Id',
  //               ),
  //             ),
  //             TextField(
  //               controller: nameController,
  //               decoration: InputDecoration(
  //                 hintText: 'What Name',
  //                 labelText: 'Name',
  //               ),
  //             ),
  //             TextField(
  //               controller: priceController,
  //               decoration: InputDecoration(
  //                 hintText: 'How Much',
  //                 labelText: 'Price',
  //               ),
  //             ),
  //             Container(
  //               margin: const EdgeInsets.all(16),
  //               child: ElevatedButton(
  //                 onPressed: ()=>$submitForm(),
  //                 child: Text('Submit'),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // void $submitForm() {
  //   final id = idController.text;
  //   final name = nameController.text;
  //   final price = priceController.text;
  //
  //   final newProduct = Product.instance(id: id, name: name, price: double.parse(price), image: null);
  //   final pmController = Get.find<PMController>();
  //   pmController.addProduct(newProduct);
  //
  //   Get.offAllNamed(RouteName.productsPage);
  // }
}
