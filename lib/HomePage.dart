// https://github.com/darshanvaru/Mood-Detector.git

import 'package:flutter/material.dart';
import 'MainCamera.dart';
import 'ContactUs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _photoClicked = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Widget page;

    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const ContactUs();
        break;
      case 2:
        page = const Placeholder();
        break;
      case 3:
        page = const Placeholder();
        break;
      case 4:
        page = const Placeholder();
        break;
      default:
        page = const Placeholder();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _togglePhotoClicked() {
    setState(() {
      _photoClicked = !_photoClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Detection'),
      ),
      drawer: Drawer(
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
              selected: _selectedIndex == 0,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Contact Us'),
              selected: _selectedIndex == 1,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              selected: _selectedIndex == 2,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About App'),
              selected: _selectedIndex == 3,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Guide'),
              selected: _selectedIndex == 4,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.circle, size: 10, color: Colors.grey),
              SizedBox(width: 10),
              Icon(Icons.circle, size: 10, color: Colors.blue),
              SizedBox(width: 10),
              Icon(Icons.circle, size: 10, color: Colors.grey),
            ],
          ),
          Expanded(
            child: Stack(
              alignment: Alignment(0, 0),
              children: <Widget>[
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[50],
                  ),
                ),
                Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[300],
                  ),
                ),
                SizedBox(
                  width: 110,
                  height: 110,
                  child: FloatingActionButton(
                    onPressed: () {
                      _togglePhotoClicked(); // This toggles the _photoClicked state
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainCamera()),
                      );
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    heroTag: null,
                    child: const Icon(Icons.camera_alt, size: 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}