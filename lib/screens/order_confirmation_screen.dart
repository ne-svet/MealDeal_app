import 'package:flutter/material.dart';
import 'package:meal_deal_app/provider/fireStore_controller.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';
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
  late Future<void> _saveOrderFuture;
  late UserOrder userOrder;

  @override
  void initState() {
    //при инициализации экрана
    super.initState();
// Поскольку initState не может быть асинхронным, вам нужно использовать альтернативный подход
    _saveOrderFuture =
        _createOrderAndSave(); // вызываем метод, который создает заказ и сохраняет его
  }

  //асинхронная операция возвращает заказ
  // Альтернативный подход для создания заказа и сохранения его
  Future<void> _createOrderAndSave() async {
    // Создание заказа
    userOrder = await context.read<MenuItemProvider>().createOrder();

    // Сохранение заказа
    await firestoreController.saveOrder(userOrder);

    // Очистка корзины
    context.read<MenuItemProvider>().clearCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
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
                  FutureBuilder<void>(
                    future: _saveOrderFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OrderWidget(orderData: userOrder.toMap()),
                              // Отображаем информацию о заказе
                              // Добавьте здесь любые другие виджеты или функциональность
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     child: Column(
                  //       children: [
                  //         OrderWidget(orderData: userOrder.toMap()),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
