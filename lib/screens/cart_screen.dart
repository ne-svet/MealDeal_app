import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/cart_item.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart'; // Импортируем ваш провайдер
import 'package:meal_deal_app/widgets/cart_widget.dart';
import 'package:meal_deal_app/widgets/my_appBar.dart';
import 'package:provider/provider.dart';

import '../widgets/green_stripe.dart';
import '../widgets/my_Drawer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final menuItemProvider =
        Provider.of<MenuItemProvider>(context); // Получаем экземпляр провайдера

    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      // Используем Consumer для обновления UI при изменении провайдера
      body: Consumer<MenuItemProvider>(
        builder: (context, menuItemProvider, child) {
          // Получаем корзину из провайдера
          final userCart = menuItemProvider.cart;

          // Рассчитываем итоговое количество и общую сумму
          final totalItems = menuItemProvider.getTotalItemCount();
          final totalPrice = menuItemProvider.getTotalPrice();

          return Column(children: [
            //зеленое меню
            GreenStripe(
              screenName: "Cart",
              screenIcon: Icons.delete,
              onPressedScreenIcon: () {
                //подтверждение удаления
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Are you sure you want to clear the cart?"),
                    actions: [
                      //отмена
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel")),
                      //удалить
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            menuItemProvider.clearCart();
                          },
                          child: Text("Yes")),
                    ],
                  ),
                );
              },
            ),
            // продукты в корзине
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty
                      ? const Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Center(child: Text("Cart is empty...")),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                //товар из корзины
                                final cartItem = userCart[index];

                                //возвращаем виджет корзины
                                return CartWidget(cartItem: cartItem);
                              }),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total items: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$totalItems',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total price:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${menuItemProvider.formatPrice(totalPrice)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color(0xFF62BD5C),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/payment');
                },
                child: const Text(
                  "Go to checkout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                )),
            const SizedBox(
              height: 20,
            )
          ]);
        },
      ),
    );
  }
}
