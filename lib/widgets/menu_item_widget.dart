import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/menu_item.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';

class MenuItemWidget extends StatelessWidget {
  //конструктор
  const MenuItemWidget({
    Key? key,
    required this.menuItem,
    required this.menuItemProvider,
  }) : super(key: key);

  final MenuItem menuItem;
  final MenuItemProvider menuItemProvider;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Фото
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      menuItem.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //название
                    Text(
                      menuItem.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //категория
                    Text(
                      menuItem.category,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Описание
                    Text(menuItem.description),
                    const SizedBox(
                      height: 10,
                    ),
                    // Ресторан
                    Text(
                      menuItem.restaurant,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Локация
                    Text(
                      menuItem.location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //цена
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "€ ${menuItem.price}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF62BD5C),
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  //кнопка ADD
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF62BD5C)),
                    ),
                    //добавляем в корзину
                    onPressed: () => menuItemProvider.addToCart(menuItem),
                    child: const Text(
                      "ADD",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
