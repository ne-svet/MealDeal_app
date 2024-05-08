import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meal_deal_app/entities/menu_item.dart';
import 'package:meal_deal_app/provider/fireStore_controller.dart';

import '../entities/cart_item.dart';
import '../entities/user_order.dart';
import '../entities/order_items.dart';

class MenuItemProvider extends ChangeNotifier {
  //Firestore
  FirestoreController firestoreController = FirestoreController();

  //получаем меню из Firestore
  Future<List<MenuItem>> getAllMenuItems() async {
    return firestoreController.getAllData();
  }

  //----------------------------------------------------------------
  //работа с товарами
  late MenuItem menuItem;

  //текущий номер заказа
  int currentOrderNumber = 1;

  //user cart
  final List<CartItem> _cart = [];

  //----------------------------------------------------------------
  //getters for cart
  //----------------------------------------------------------------
  List<CartItem> get cart => _cart;

  //----------------------------------------------------------------
  //add to cart
  //----------------------------------------------------------------
  void addToCart(MenuItem menuItem) {
    // Проверяем, существует ли уже такой товар в корзине
    CartItem? existingCartItem =
    _cart.firstWhereOrNull((item) => item.menuItem == menuItem);

    // Если товар уже существует - увеличиваем количество
    if (existingCartItem != null) {
      existingCartItem.quantity++;
    } else {
      // Если товара еще нет в корзине, добавляем его
      _cart.add(CartItem(menuItem: menuItem));
    }

    // Оповещаем слушателей для обновления UI
    notifyListeners();
  }

//----------------------------------------------------------------
  //remove from cart
//----------------------------------------------------------------
  void removeFromCart(CartItem cartItem) {
    //количство продукта
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      //если больше 1 - уменьшаем количество
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      }
      //если 1 штука, то удаляем
      else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

//----------------------------------------------------------------
//get the total price of the cart
//----------------------------------------------------------------
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.menuItem.price;

      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

//----------------------------------------------------------------
//get total number  of items in cart
//----------------------------------------------------------------
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

//----------------------------------------------------------------
//clear cart
//----------------------------------------------------------------
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //---------------------------------------------------------------
  // получить номер заказа
  //---------------------------------------------------------------
  String getOrderNumber() {
    String orderPrefix = 'MD - '; // Префикс заказа
    String newOrderNumber = currentOrderNumber.toString().padLeft(
        8, '0'); // Нумерация с ведущими нулями до 8 цифр
    currentOrderNumber++;
    return '$orderPrefix$newOrderNumber';
  }

  //----------------------------------------------------------------
//generate a receipt
  //----------------------------------------------------------------
  UserOrder createOrder() {
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(
        DateTime.now());

    List<OrderItem> orderItems = _cart.map((cartItem) {
      return OrderItem(
        restaurant: cartItem.menuItem.restaurant,
        location: cartItem.menuItem.location,
        itemName: cartItem.menuItem.name,
        price: cartItem.menuItem.price,
        quantity: cartItem.quantity,
      );
    }).toList();


     UserOrder order = UserOrder(
        orderNumber: getOrderNumber(),
        formattedDate: formattedDate,
        items: orderItems,
        totalItems: getTotalItemCount(),
        totalPrice: _formatPrice(getTotalPrice()),

    );

    return order;


    //   //долгий стринг
    //   final receipt = StringBuffer();
    //   final orderNumber = getOrderNumber();
    //   receipt.writeln('Here is you receipt.');
    //   receipt.writeln();
    //
    //   String formattedDate =
    //       DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    //
    //   receipt.writeln(formattedDate);
    //   receipt.writeln('Order Number: $orderNumber');
    //   receipt.writeln();
    //   receipt.writeln('-----------------');
    //
    //   for (final cartItem in _cart) {
    //     receipt.writeln("Restaurant: ${cartItem.menuItem.restaurant}");
    //     receipt.writeln("Location: ${cartItem.menuItem.location}");
    //     receipt.writeln();
    //     receipt.writeln(
    //         "${cartItem.quantity} x ${cartItem.menuItem.name} - ${_formatPrice(cartItem.menuItem.price)}");
    //
    //     receipt.writeln('-----------------');
    //   }
    //
    //   receipt.writeln();
    //   receipt.writeln("Total items: ${getTotalItemCount()}");
    //   receipt.writeln("Total price: ${_formatPrice(getTotalPrice())}");
    //
    //
    //   return receipt.toString();
  }

  //----------------------------------------------------------------
//format double into money
  //----------------------------------------------------------------
  String _formatPrice(double price) {
    return "€ ${price.toStringAsFixed(2)}";
  }

  //  добавляет новые записи в историю
  Future<void> addOrder(UserOrder userOrder) async {

    await firestoreController.saveOrder(userOrder);
    notifyListeners(); //оповещаем слушателей, когда история обновляется
  }

  //получение данных
  Future<List<UserOrder>> getAllOrderHistory() async {
    return firestoreController.getAllOrders();
  }
}
