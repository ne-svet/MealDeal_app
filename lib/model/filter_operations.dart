import '../entities/menu_item.dart';
import '../provider/fireStore_controller.dart';

class FilterOperations {
  final FirestoreController firestoreController = FirestoreController();

  // Универсальная функция для извлечения уникальных значений из списка объектов MenuItem
  Future<List<String>> getUniqueValues(
      String Function(MenuItem) getValue) async {
    final List<MenuItem> menuItems = await firestoreController.getAllData();
    final Set<String> uniqueValues = {};

    menuItems.forEach((menuItem) {
      uniqueValues.add(getValue(menuItem));
    });

    return uniqueValues.toList();
  }

  // Функция для получения уникальных категорий
  Future<List<String>> getCategories() async {
    return getUniqueValues((menuItem) => menuItem.category);
  }

  // Функция для получения уникальных ресторанов
  Future<List<String>> getRestaurants() async {
    return getUniqueValues((menuItem) => menuItem.restaurant);
  }

  // Функция для получения уникальных локаций
  Future<List<String>> getLocations() async {
    return getUniqueValues((menuItem) => menuItem.location);
  }
}
