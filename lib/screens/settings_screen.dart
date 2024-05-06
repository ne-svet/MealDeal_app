import 'package:flutter/material.dart';
import 'package:meal_deal_app/widgets/my_Drawer.dart';
import 'package:meal_deal_app/widgets/my_appBar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
    );
  }
}
