import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meal_deal_app/entities/menu_item.dart';
import 'package:meal_deal_app/provider/fireStore_controller.dart';

import '../entities/cart_item.dart';
import '../entities/user_order.dart';
import '../entities/order_items.dart';
import '../model/firebase_auth_services.dart';

class MenuItemProvider extends ChangeNotifier {
  //Firestore
  FirestoreController firestoreController = FirestoreController();

  //получаем меню из Firestore
  Future<List<MenuItem>> getAllMenuItems() async {
    return firestoreController.getAllData();
  }

  //получаем меню из Firestore по категориям
  Future<List<MenuItem>> getMenuItemsByCategories(
      List<String> selectedCategories) async {
    return firestoreController.getAllDataByCategiries(selectedCategories);
  }

  //----------------------------------------------------------------
  //получаем меню из Firestore по всем фильтрам
  Future<List<MenuItem>> getAllDataBySelectedFilters(
    List<String> selectedCategories,
    List<String> selectedRestaurants,
    List<String> selectedLocations,
  ) async {
    return firestoreController.getAllDataBySelectedFilters(
        selectedCategories, selectedRestaurants, selectedLocations);
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
  // Получение текущего номера заказа из базы данных Firebase
  //---------------------------------------------------------------

  Future<int?> getCurrentOrderNumber() async {
    try {
      // Получаем экземпляр Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Получаем документ с текущим номером заказа из коллекции 'order_numbers'
      DocumentSnapshot documentSnapshot = await firestore
          .collection('order_num')
          .doc('current_order_num')
          .get();

      // Проверяем, существует ли документ и содержит ли он поле 'number'
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        // Приводим данные к типу Map<String, dynamic>
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Получаем текущий номер заказа из поля 'number'
        int currentOrderNumber = data['number'];

        // Возвращаем текущий номер заказа
        return currentOrderNumber;
      } else {
        // Если документ не существует или не содержит поля 'number', возвращаем null
        return null;
      }
    } catch (error) {
      // Если произошла ошибка при загрузке текущего номера заказа, возвращаем null
      print('Error getting current order number: $error');
      return null;
    }
  }

  //---------------------------------------------------------------
  // Сохранение обновленного номера заказа в базе данных Firebase
  //---------------------------------------------------------------
  Future<void> saveCurrentOrderNumber(int newOrderNumber) async {
    try {
      // Получаем экземпляр Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Обновляем поле 'number' в документе 'current_order_num' коллекции 'order_num'
      await firestore
          .collection('order_num')
          .doc('current_order_num')
          .update({'number': newOrderNumber});
    } catch (error) {
      // Если произошла ошибка при сохранении номера заказа, выводим сообщение об ошибке
      print('Error saving current order number: $error');
    }
  }

  //---------------------------------------------------------------
  // получить номер заказа
  //---------------------------------------------------------------
  Future<String> getOrderNumber() async {
    // Получение текущего номера заказа из базе данных
    int currentOrderNumber = await getCurrentOrderNumber() ?? 55;

    String orderPrefix = 'MD - '; // Префикс заказа

    String newOrderNumber = currentOrderNumber
        .toString()
        .padLeft(8, '0'); // Нумерация с ведущими нулями до 8 цифр

    // Увеличение текущего номера заказа на единицу
    currentOrderNumber++;

    // Сохранение обновленного номера заказа в базе данных
    await saveCurrentOrderNumber(currentOrderNumber);

    // Возврат нового номера заказа
    return '$orderPrefix$newOrderNumber';
  }

  //-----------------------------------------------------------`-----
//generate a receipt
  //----------------------------------------------------------------
  Future<UserOrder> createOrder() async {
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

    // получение userId
    String userId = await FireBaseAuthService.getUserId();

    List<OrderItem> orderItems = _cart.map((cartItem) {
      return OrderItem(
        userId: userId,
        restaurant: cartItem.menuItem.restaurant,
        location: cartItem.menuItem.location,
        itemName: cartItem.menuItem.name,
        price: cartItem.menuItem.price,
        quantity: cartItem.quantity,
      );
    }).toList();

    String num = await getOrderNumber();

    UserOrder order = UserOrder(
      userId: userId,
      orderNumber: num,
      formattedDate: formattedDate,
      items: orderItems,
      totalItems: getTotalItemCount(),
      totalPrice: formatPrice(getTotalPrice()),
    );

    return order;
  }

  //----------------------------------------------------------------
//format double into money
  //----------------------------------------------------------------
  String formatPrice(double price) {
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
