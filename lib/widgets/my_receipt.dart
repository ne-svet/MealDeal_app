// import 'package:flutter/material.dart';
// import 'package:meal_deal_app/provider/menu_item_provider.dart';
// import 'package:provider/provider.dart';
//
// class MyReceipt extends StatefulWidget {
//   const MyReceipt({super.key});
//
//   @override
//   State<MyReceipt> createState() => _MyReceiptState();
// }
//
// class _MyReceiptState extends State<MyReceipt> {
//   @override
//   void initState() {
//     super.initState();
//     // Увеличиваем currentOrderNumber при инициализации виджета
//     Provider.of<MenuItemProvider>(context, listen: false).currentOrderNumber++;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             'Thank you for your order!',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'Now resaurant will contact you...',
//             style: TextStyle(fontSize: 14),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.green),
//                 borderRadius: BorderRadius.circular(10)),
//             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//             child: Consumer<MenuItemProvider>(
//                 builder: (context, menuItemProvider, child) {
//               return Text(menuItemProvider.displayCartReceipt());
//             }),
//           )
//         ],
//       ),
//     );
//   }
// }
