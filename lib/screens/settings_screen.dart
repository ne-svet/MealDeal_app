import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_deal_app/widgets/green_stripe.dart';
import 'package:meal_deal_app/widgets/my_Drawer.dart';
import 'package:meal_deal_app/widgets/my_appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_deal_app/widgets/text_box.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // пользователи из таблицы
  final usersCollection = FirebaseFirestore.instance.collection("users");

  // поля для изменения
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // кнопка отмены
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // кнопка сохранения
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );

    // обновление в БД только в случае, если в текстовом поле есть хоть что-то
    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          // получаем данные
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              children: [
                GreenStripe(
                  screenName: "Settings",
                  screenIcon: null,
                  onPressedScreenIcon: null,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Icon(
                        Icons.person,
                        size: 72,
                      ),
                      Text(
                        currentUser.email!,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          "My Details",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      //имя пользователя
                      TextBox(
                        text: userData['first name'],
                        sectionName: "Username",
                        onPressed: () => editField('first name'),
                      ),
                      //фамилия пользователя
                      TextBox(
                        text: userData['last name'],
                        sectionName: "Lastname",
                        onPressed: () => editField("last name"),
                      ),
                      //email
                      TextBox(
                        text: userData['email'],
                        sectionName: "Email ",
                        onPressed: () => editField("email"),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
