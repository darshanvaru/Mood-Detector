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
      backgroundColor: Colors.blue[50],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(43),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: ListTile(
                    leading: const Icon(Icons.contact_mail),
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
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: ListTile(
                    leading: const Icon(Icons.group),
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
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: ListTile(
                    leading: const Icon(Icons.info),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ListTile(
                  leading: const Icon(Icons.help),
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
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0), // Light top border
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)), // Apply the same roundness to the ClipRRect
        child: BottomNavigationBar(
          onTap: (index) => _onItemTapped(context, index),
          currentIndex: selectedIndex,
          backgroundColor: Colors.blue[50],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          // Hide the labels when selected
          showUnselectedLabels: false,
          // Hide the labels when not selected
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 33),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 33,),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
