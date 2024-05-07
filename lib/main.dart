import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meal_deal_app/firebase_options.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';
import 'package:meal_deal_app/screens/auth_screen.dart';
import 'package:meal_deal_app/screens/cart_screen.dart';
import 'package:meal_deal_app/screens/filter_screen.dart';
import 'package:meal_deal_app/screens/history_screen.dart';
import 'package:meal_deal_app/screens/login_or_register_screen.dart';
import 'package:meal_deal_app/screens/menu_screen.dart';
import 'package:meal_deal_app/screens/order_confirmation_screen.dart';
import 'package:meal_deal_app/screens/payment_screen.dart';
import 'package:meal_deal_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  //инициализация Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MenuItemProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
        '/confirmation': (context) => const OrderConfirmationScreen(),
        '/filter': (context) => FilterScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
