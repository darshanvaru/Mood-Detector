import 'package:flutter/material.dart';

import '../screens/AboutApp.dart';
import '../screens/AboutUs.dart';
import '../screens/ContactUs.dart';
import '../screens/Guide.dart';
import '../screens/HomePage.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const AppBottomNavBar({
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
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: 'Contact Us',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About Us',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: 'About App',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline),
          label: 'Guide',
        ),
      ],
    );
  }
}
