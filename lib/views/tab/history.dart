




class LihatDiViewsOrder{
  static const order_page ='/views/order/order_list.dart';
}

// import 'package:flutter/material.dart';
//
// class UjiCoba extends StatelessWidget {
//   final List<String> items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//     'Item 6',
//     'Item 7',
//     'Item 8',
//     'Item 9',
//     'Item 10',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Elegant List'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               elevation: 2.0,
//               child: ListTile(
//                 contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                 title: Text(
//                   items[index],
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//                 subtitle: Text(
//                   'Subtitle',
//                   style: Theme.of(context).textTheme.subtitle2,
//                 ),
//                 leading: CircleAvatar(
//                   backgroundImage: AssetImage('assets/image.jpg'),
//                 ),
//
//                 onTap: () {
//                   // Aksi yang ingin dilakukan saat item di-tap
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }