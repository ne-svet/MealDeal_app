import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/menu_item.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuItemWidget extends StatelessWidget {


  final MenuItem menuItem;
  final MenuItemProvider menuItemProvider;

  //конструктор
  const MenuItemWidget({
    Key? key,
    required this.menuItem,
    required this.menuItemProvider,
  }) : super(key: key);


  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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
                    InkWell(
                      onTap: () => launchUrl(Uri.parse(menuItem.link)),
                      child: Text(
                        "Restaurant: ${menuItem.restaurant}",
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            //fontSize: 18,
                            color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Локация
                    Text(
                      "Location: ${menuItem.location}",
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
                    onPressed: () {
                      menuItemProvider.addToCart(menuItem);
                    },
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
