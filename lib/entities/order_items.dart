class OrderItem {
  final String userId;
  final String restaurant;
  final String location;
  final String itemName;
  final double price;
  final int quantity;

  OrderItem({
    required this.userId,
    required this.restaurant,
    required this.location,
    required this.itemName,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      'restaurant': restaurant,
      'location': location,
      'itemName': itemName,
      'price': price,
      'quantity': quantity,
    };
  }

  // Преобразование данных при загрузке из БД
  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      userId: map['userId'],
      restaurant: map['restaurant'],
      location: map['location'],
      itemName: map['itemName'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
