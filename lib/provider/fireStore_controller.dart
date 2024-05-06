import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meal_deal_app/entities/menu_item.dart';

import '../firebase_options.dart';

class FirestoreController {
  //создаем объект с БД
  late FirebaseFirestore db;

  //инициализация Firebase
  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    db = FirebaseFirestore.instance;
  }

  //получение данных
  @override
  //функция получает список объектов PhotoMemory
  Future<List<MenuItem>> getAllData() async {
    //вначале инициализируем
    await init();
    //формат json map формат
    QuerySnapshot snapshot = await db.collection('product_db').get();

    //обработать все объекты из коллекции  product_db
    List<MenuItem> menuItems = snapshot.docs.map((item) {
      Map<String, dynamic> data = item.data() as Map<String, dynamic>;
      return MenuItem.fromMap(data);
    }).toList();
    //возвращаем список
    return menuItems;
  }
}
