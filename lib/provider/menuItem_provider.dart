import 'package:flutter/cupertino.dart';
import 'package:meal_deal_app/entities/menu_item.dart';
import 'package:meal_deal_app/provider/fireStore_controller.dart';

class MenuItemProvider extends ChangeNotifier {
  FirestoreController firestoreController = FirestoreController();

  //получаем меню
  Future<List<MenuItem>> getAllMenuItems() async {
    return firestoreController.getAllData();
  }
}
