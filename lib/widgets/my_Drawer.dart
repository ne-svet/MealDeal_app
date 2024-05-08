import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/logo_ver1.png"),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
            ),
            child: Container(),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Menu'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/menu');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Orders History'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/orderHistory');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
          const SizedBox(
            height: 150,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
