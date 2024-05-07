import 'package:flutter/material.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';
import 'package:meal_deal_app/widgets/quantity_selector.dart';
import 'package:provider/provider.dart';

import '../entities/cart_item.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.cartItem,
  });

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuItemProvider>(
        builder: (context, menuItemProvider, child) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8)
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-------------------------------
                    //image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        cartItem.menuItem.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(width: 10,),
                    //-------------------------------
                    //name and price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cartItem.menuItem.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                              fontSize: 16

                            ),),
                          SizedBox(height: 30,),
                          Text("€ ${cartItem.menuItem.price}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF62BD5C)

                          ),),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    //-------------------------------
                    //increment or decrement quantity
                    QuantitySelector(
                        menuItem: cartItem.menuItem,
                        quantity: cartItem.quantity,
                        onDecrement: () {
                          menuItemProvider.removeFromCart(cartItem);
                        },
                        onIncrement: () {
                          menuItemProvider.addToCart(cartItem.menuItem);
                        },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}