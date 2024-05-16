import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/menu_item.dart';

//виджет для изменения кол-ва порций
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final MenuItem menuItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector(
      {super.key,
      required this.menuItem,
      required this.quantity,
      required this.onDecrement,
      required this.onIncrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //-------------------------------
          //decrese button
          GestureDetector(
            onTap: onDecrement,
            child: Icon(
              Icons.remove,
              size: 15,
              color: Colors.grey,
            ),
          ),
          //-------------------------------
          //quantity count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 25,
              child: Center(
                child: Text(
                  quantity.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          //-------------------------------
          //increase button
          GestureDetector(
            onTap: onIncrement,
            child: Icon(
              Icons.add,
              size: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
