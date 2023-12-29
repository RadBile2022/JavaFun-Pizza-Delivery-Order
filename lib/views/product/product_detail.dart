import 'package:pizza_order/views/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_name.dart';
import 'ProductController.dart';
import 'logic/product.dart';
import 'logic/product_contoller.dart';

class ProductDetailPage extends StatelessWidget {
  final pmController = Get.find<PMController>();
  final idProduct = Get.arguments;
  late Product? p ;

  // DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    pmController.readData();
    p = pmController.findProductById(idProduct);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:


      SingleChildScrollView(
        child: Column(
          children: [
            imageSection(context),
            titleSection(),
            iconSection(context),
            descSection(),
            bundlingSection(),
            orderSection,
          ],
        ),
      ),
    );
  }

  Widget imageSection(BuildContext context) => Stack(
        children: <Widget>[
          Image.network(
            p!.imageNetwork,
            width: 600,
            height: 340,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.offAllNamed(RouteName.productsPage);
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) {
                        //       return ListScreen();
                        //     }));
                      },
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey[500],
                          child: IconButton(
                            onPressed: () => showDialogBox(
                              context,
                              'Product',
                              p!.name,
                              $onPressedDeleted,
                            ),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )

                          // onPressed: () {
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //         title: const Text('Delete Product'),
                          //         content: Text(
                          //             'Are you sure you want to delete ${p!.name}'),
                          //         actions: [
                          //           TextButton(
                          //             onPressed: () {
                          //               pmController.deleteProduct(p!);
                          //               Get.offAllNamed(RouteName.productsPage);
                          //             },
                          //             child: const Text('Delete'),
                          //           ),
                          //           TextButton(
                          //             onPressed: () {
                          //               Navigator.pop(context); // Tutup dialog
                          //             },
                          //             child: const Text('Cancel'),
                          //           ),
                          //         ],
                          //       );
                          //     },
                          //   );
                          // },
                          ),
                      const SizedBox(width: 5),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.toNamed(RouteName.productEdit,
                                arguments: idProduct);
                            //
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //       return EditScreen(
                            //         p: p,
                            //         index: index,
                            //       );
                            //     }));
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            var snackBar = SnackBar(
                              content: Text(
                                'Anda Berhasil Membagi ${p!.name.toString()}',
                                textAlign: TextAlign.center,
                              ),
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                      ),
                    ],
                  ),
                  // const FavoriteButton(),
                ],
              ),
            ),
          ),
        ],
      );

  Widget titleSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    p!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
                Text(
                  p!.category,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const FavoriteButton(),
          const Text('10'),
        ],
      ),
    );
  }

  Column _buildIcon(Color color, IconData icon, String label, String price) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      );

  Widget iconSection(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIcon(color, Icons.ad_units, 'PREP:', p!.iconPrep),
        _buildIcon(color, Icons.lock_clock, 'COOK:', p!.iconCook),
        _buildIcon(
            color, Icons.monetization_on_sharp, 'PRICE:', '\$ ${p!.iconPrice}'),
      ],
    );
  }

  Widget descSection() {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Text(
          p!.desc,
          softWrap: true,
          style: TextStyle(fontFamily: 'Lexend'),
        ),
      ),
    );
  }

  Widget bundlingSection() => Padding(
        padding: EdgeInsets.only(left: 32, bottom: 28),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 12),
              child: const Text(
                'Bonus Bundling : ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: p!.bonusBundling.map((bonus) {
                    return Card(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                            child: Image.network(bonus.image),
                          ),
                          Text(
                            bonus.title,
                          ),
                        ],
                      ),
                    );
                  }).toList()),
            ),
          ],
        ),
      );

  final Widget orderSection = Padding(
    padding: const EdgeInsets.only(bottom: 32),
    child: ElevatedButton(onPressed: () {}, child: const Text('Order')),
  );

  void $onPressedDeleted() {
    pmController.deleteProduct(p!);
    Get.offAllNamed(RouteName.productsPage);
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }
}
