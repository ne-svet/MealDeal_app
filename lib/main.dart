import 'package:flutter/material.dart';
import 'package:meal_deal_app/screens/auth_screen.dart';
import 'package:meal_deal_app/screens/cart_screen.dart';
import 'package:meal_deal_app/screens/history_screen.dart';
import 'package:meal_deal_app/screens/login_or_register_screen.dart';
import 'package:meal_deal_app/screens/menu_screen.dart';
import 'package:meal_deal_app/screens/payment_screen.dart';
import 'package:meal_deal_app/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Deal',
      routes: {
        '/': (context) => const AuthScreen(),
        '/loginOrRegister': (context) => LoginOrRegisterScreen(),
        '/menu': (context) => MenuScreen(),
        '/orderHistory': (context) => const OrderHistoryScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/cart': (context) => const CartScreen(),
        '/payment': (context) => const PaymentScreen(),
      },
    );
  }
}

