import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:meal_deal_app/entities/menu_item.dart';
import 'package:meal_deal_app/entities/user_order.dart';

import '../firebase_options.dart';

class FirestoreController {
  //создаем объект с БД
  late FirebaseFirestore db;

  //---------------------------------------
  //инициализация Firebase
  //---------------------------------------
  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    db = FirebaseFirestore.instance;
  }

  //---------------------------------------
  //получение данных
  //---------------------------------------
  @override
  //функция получает список объектов MenuItem
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

  // Универсальная функция для извлечения уникальных значений из списка объектов MenuItem
  Future<List<String>> getUniqueValues (

      String Function(MenuItem) getValue) async {
    await init();
    final List<MenuItem> menuItems = await getAllData();
    final Set<String> uniqueValues = {};

    menuItems.forEach((menuItem) {
      uniqueValues.add(getValue(menuItem));
    });

    return uniqueValues.toList();
  }

//---------------------------------------
//сохранить заказ
//---------------------------------------
  Future<void> saveOrder(UserOrder userOrder) async {
    await init();
    try {
      // Преобразуем UserOrder в Map
      Map<String, dynamic> data = userOrder.toMap();

      DocumentReference docRef =
      await db.collection('user_orders').add(data);
    }catch(e){
      print('Error saving order: $e');
      throw e;
    }



  }


//   //---------------------------------------
// // сохранить заказ
// //---------------------------------------
//   void saveOrder(String inputText) async {
//     // Если ввод или перевод пустые, не сохраняем
//     if (inputText.isEmpty || output.isEmpty) {
//       return;
//     }
//     try {
//       // Получаем userId асинхронно
//       String userId = await Authentication.getUserId();
//
//       // Создаем новый объект TranslationHistory
//       TranslationHistory newHistory = TranslationHistory(
//         userId: userId,
//         input: inputText,
//         output: output,
//         date: Timestamp.now(),
//       );
//
//       // Добавляем расчет в историю, создав объект TranslationHistory
//       historyProvider.addTranslationHistory(TranslationHistory(
//         userId: userId,
//         input: inputText,
//         output: output,
//         date: Timestamp.now(),
//       ));
//       updateStateCallback();
//     } catch (error) {
//       print("Error saving translation history: $error");
//       // Можно добавить обработку ошибки здесь
//     }
//   }


  //---------------------------------------
  //сохранение заказа в историю
  //---------------------------------------
  // @override
  // Future<void> saveToOrderHistory(CartItem cartItem) async {
  //   await init();
  //   try {
  //     //String userId = await Authentication.getUserId();
  //
  //     // Преобразуем translationHistory в Map
  //     Map<String, dynamic> data = translationHistory.toMap();
  //
  //     // // Добавляем userId к данным, которые будут сохранены
  //     // data['userId'] = userId;
  //
  //     // Добавляем запись в коллекцию 'translationHistory'
  //     DocumentReference docRef =
  //     await db.collection('translationHistory').add(data);
  //
  //     // Не нужно присваивать translationHistory.id, так как он автоматически присваивается Firestore
  //   } catch (e) {
  //     print('Error saving translation history: $e');
  //     throw e;
  //   }
  // }

  //получаем историю заказов
  Future<List<UserOrder>> getAllOrders() async {
    await init();

    QuerySnapshot snapshot = await db
        .collection('user_orders')
    //------------------------------------------------------------------------
    //когда будет пользователь
    // // выбираем по UserID
    //     .where('userId', isEqualTo: userId)
    //------------------------------------------------------------------------
    //сортируем по дате
        .orderBy('formattedDate', descending: true)
        .get();
    //обрабатываем snapshot,
    // из каждого документа docs делаем UserOrder
    //получаем список и возвращаем history
    List<UserOrder> userOrders = snapshot.docs.map((doc) {
      // Получаем данные документа в виде Map
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // Создаем объект UserOrder, передавая данные и идентификатор документа
      return UserOrder.fromMap(data);
    }).toList();
    return userOrders;
  }
}
