import 'order_items.dart';

class UserOrder {
  final String userId;
  final String orderNumber;
  final String formattedDate;
  final List<OrderItem> items;
  final int totalItems;
  final String totalPrice;

  UserOrder({
    required this.userId,
    required this.orderNumber,
    required this.formattedDate,
    required this.items,
    required this.totalItems,
    required this.totalPrice,
  });

  //запись в БД
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      'orderNumber': orderNumber,
      'formattedDate': formattedDate,
      'items': items.map((item) => item.toMap()).toList(),
      'totalItems': totalItems,
      'totalPrice': totalPrice,
    };
  }


  //преобразование данных для загрузки из БД
//пишем функцию fromMap
  factory UserOrder.fromMap(
      Map<String, dynamic> map) {

    // Преобразуем список items из Map в список объектов OrderItem
    List<OrderItem> orderItems = List<OrderItem>.from(map['items'].map((item) => OrderItem.fromMap(item)));


    UserOrder userOrder = UserOrder(
        userId: map['userId'],
        orderNumber: map['orderNumber'],
        formattedDate: map['formattedDate'],
        items: orderItems,
        totalItems: map['totalItems'],
        totalPrice: map['totalPrice']);

    return userOrder;
  }
}





