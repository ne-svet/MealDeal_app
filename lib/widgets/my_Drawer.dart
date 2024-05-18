import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_deal_app/entities/toast.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                widthFactor: 0.8, // Adjust the width factor to control the size
                child: Image.asset(
                  "lib/assets/images/Logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('MENU',
            style: TextStyle(
              fontSize: 16
            ),),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/menu');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('ORDERS HISOTORY'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/orderHistory');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('SETTINGS'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
          // const SizedBox(
          //   height: 150,
          // ),
          const Spacer(flex: 2),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LOG OUT'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
              //showToast(message: "Successfully signed out");
            },
          ),
        ],
      ),
    );
  }
}
