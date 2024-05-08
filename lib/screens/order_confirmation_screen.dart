import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/menu_item.dart';
import 'package:meal_deal_app/provider/fireStore_controller.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';
import 'package:meal_deal_app/widgets/my_receipt.dart';
import 'package:meal_deal_app/widgets/order_widget.dart';
import 'package:provider/provider.dart';

import '../entities/user_order.dart';
import '../widgets/green_stripe.dart';
import '../widgets/my_Drawer.dart';
import '../widgets/my_appBar.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  FirestoreController firestoreController = FirestoreController();
  late UserOrder userOrder;

  @override
  void initState() {
    //при инициализации экрана
    super.initState();
//создаем заказ
    userOrder = context.read<MenuItemProvider>().createOrder();


    //сохраняем заказ
    firestoreController.saveOrder(userOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Column(
        children: [
          GreenStripe(
            screenName: "Order confirmation",
            screenIcon: null,
            onPressedScreenIcon: null,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OrderWidget(orderData: userOrder.toMap()),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Color(0xFF62BD5C),
              ),
              onPressed: () => Navigator.pushNamed(context, '/menu'),
              child: const Text(
                "Go to menu",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              )),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
