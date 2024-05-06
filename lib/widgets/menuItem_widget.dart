import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/menu_item.dart';
import 'package:http/http.dart' as http;

class MenuItemWidget extends StatelessWidget {

  MenuItemWidget({super.key, required this.menuItem});

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [

            // Фото
            Column(
              children: [
                ClipRRect(
                  child: Image.network(
                    menuItem.imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),

              ],
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //категория
                    Text(
                      menuItem.category,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // Описание
                    Text(menuItem.description),
                    SizedBox(
                      height: 10,
                    ),
                    // Ресторан
                    Text(
                      menuItem.restaurant,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Локация
                    Text(
                      menuItem.location,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //цена
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "€ " + menuItem.price.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF62BD5C),
                      fontSize: 20),
                ),
                SizedBox(
                  height: 150,
                ),
                //кнопка ADD
                ElevatedButton(
                  onPressed: () {
                    //TODO добавление в корзину
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize:18, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF62BD5C)),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
