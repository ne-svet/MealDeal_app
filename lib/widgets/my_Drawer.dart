import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Menu'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/menu');
            },
          ),
          ListTile(
            title: const Text('Orders History'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/orderHistory');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
