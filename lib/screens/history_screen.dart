import 'package:flutter/material.dart';
import 'package:meal_deal_app/widgets/my_Drawer.dart';

import '../widgets/my_appBar.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
    );
  }
}
