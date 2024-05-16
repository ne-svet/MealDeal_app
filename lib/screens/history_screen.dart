import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_deal_app/entities/user_order.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';
import 'package:meal_deal_app/widgets/my_Drawer.dart';
import 'package:meal_deal_app/widgets/order_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/green_stripe.dart';
import '../widgets/my_appBar.dart';

class OrderHistoryScreen extends StatefulWidget {
  OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: Column(children: [
          GreenStripe(
            screenName: "Orders history",
            screenIcon: null,
            onPressedScreenIcon: null,
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: FutureBuilder<List<UserOrder>>(
                      //задаем функцию достать историю
                      future: Provider.of<MenuItemProvider>(context)
                          .getAllOrderHistory(),
                      //какой виджет показывать ---->
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return Column(
                            children: snapshot.data!.map((order) {
                              return OrderWidget(orderData: order.toMap());
                            }).toList(),
                          );
                        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return const Center(
                            heightFactor: 30,
                            child: Text('History is empty now'),
                          );
                        } else {
                          return const Center(
                            heightFactor: 18,
                            child: CircularProgressIndicator(),
                          );
                        }
                      })))
        ]));
  }
}
