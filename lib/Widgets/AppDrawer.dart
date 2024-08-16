import 'package:flutter/material.dart';

import '../AboutApp.dart';
import '../AboutUs.dart';
import '../ContactUs.dart';
import '../Guide.dart';
import '../HomePage.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;

  const AppDrawer({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const ContactUs();
        break;
      case 2:
        page = const AboutUs();
        break;
      case 3:
        page = const AboutApp();
        break;
      case 4:
        page = const Guide();
        break;
      default:
        page = const Guide();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: selectedIndex == 0,
            selectedTileColor: Colors.blue.shade100,
            onTap: () => _onItemTapped(context, 0),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Contact Us'),
            selected: selectedIndex == 1,
            selectedTileColor: Colors.blue.shade100,
            onTap: () => _onItemTapped(context, 1),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            selected: selectedIndex == 2,
            selectedTileColor: Colors.blue.shade100,
            onTap: () => _onItemTapped(context, 2),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About App'),
            selected: selectedIndex == 3,
            selectedTileColor: Colors.blue.shade100,
            onTap: () => _onItemTapped(context, 3),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Guide'),
            selected: selectedIndex == 4,
            selectedTileColor: Colors.blue.shade100,
            onTap: () => _onItemTapped(context, 4),
          ),
        ],
      ),
    );
  }
}