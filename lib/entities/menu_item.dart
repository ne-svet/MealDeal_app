class MenuItem {
  String category;
  String name;
  String description;
  String imageUrl;
  String restaurant;
  String link;
  String location;
  bool onSale;
  double price;
  int quantity;

  //конструктор
MenuItem (
    this.category, this.name,this.description, this.imageUrl, this.restaurant, this.link, this.location, this.onSale, this.price, this.quantity
    );

//объект MenuItem для БД. Сериализация данных
  Map<String, Object> toMap() {
    return {
      'category': category,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'restaurant': restaurant,
      'link': link,
      'location': location,
      'on_sale': onSale,
      'price': price,
      'quantity': quantity,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    //из объекта БД создаем объект PhotoMemory
    MenuItem menuItem =
    MenuItem(
        map['category'],
        map['name'],
      map['description'],
      map['image_url'],
      map['restaurant'],
      map['link'],
      map['location'],
      map['on_sale'],
      (map['price']).toDouble(), // Преобразование int в double
      map['quantity'],
    );

    return menuItem;
  }

  //переписываем методы сравнения
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MenuItem &&
        other.category == category &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.restaurant == restaurant &&
        other.link == link &&
        other.location == location &&
        other.onSale == onSale &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return category.hashCode ^
    name.hashCode ^
    description.hashCode ^
    imageUrl.hashCode ^
    restaurant.hashCode ^
    link.hashCode ^
    location.hashCode ^
    onSale.hashCode ^
    price.hashCode ^
    quantity.hashCode;
  }

}