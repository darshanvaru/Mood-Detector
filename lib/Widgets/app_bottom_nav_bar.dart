import 'package:flutter/material.dart';

import '../screens/about_app.dart';
import '../screens/about_us.dart';
import '../screens/contact_us.dart';
import '../screens/guide.dart';
import '../screens/home_page.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final int? selectedSettingIndex;

  const AppBottomNavBar({
    super.key,
    this.selectedSettingIndex,
    required this.selectedIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      if (selectedIndex == 0) {
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      _showSettingsDrawer(context);
    }
  }

  void _showSettingsDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.pop(context); // Closing bottom sheet
                if (selectedSettingIndex != 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactUs()),
                  );
                } else {
                  return;
                }
              },
              selected: false,
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                if (selectedSettingIndex != 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUs()),
                  );
                } else {
                  return;
                }
              },
              selected: false,
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About App'),
              onTap: () {
                Navigator.pop(context);
                if (selectedSettingIndex != 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutApp()),
                  );
                } else {
                  return;
                }
              },
              selected: false,
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Guide'),
              onTap: () {
                Navigator.pop(context);
                if (selectedSettingIndex != 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Guide()),
                  );
                } else {
                  return;
                }
              },
              selected: false,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => _onItemTapped(context, index),
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      // Hide the labels when selected
      showUnselectedLabels: false,
      // Hide the labels when not selected
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
