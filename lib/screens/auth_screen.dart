import 'package:flutter/material.dart';
import 'package:meal_deal_app/widgets/my_Drawer.dart';
import 'package:meal_deal_app/widgets/my_appBar.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
    );
  }
}
