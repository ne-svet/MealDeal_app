import 'package:flutter/material.dart';
import 'package:meal_deal_app/widgets/my_receipt.dart';

import '../widgets/green_stripe.dart';
import '../widgets/my_Drawer.dart';
import '../widgets/my_appBar.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

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
          MyReceipt(),
        ],
      ),
    );
  }
}
