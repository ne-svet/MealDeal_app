import 'package:flutter/material.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
    child: Column(
      children: [
        SizedBox(height: 20,),
        Text('Thank you for your order!', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.all(10),
          child: Consumer<MenuItemProvider>(
              builder: (context,menuItemProvider, child) => Text(menuItemProvider.displayCartReceipt())),
        )

      ],
    ),);
  }
}
