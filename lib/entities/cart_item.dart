import 'package:meal_deal_app/entities/menu_item.dart';

//корзина
class CartItem {
  MenuItem menuItem;
  int quantity;

  CartItem({required this.menuItem, this.quantity = 1});

  double get totalPrice {
    return menuItem.price * quantity;
  }
}
