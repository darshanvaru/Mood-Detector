import 'package:flutter/material.dart';
import 'ContactUs.dart';
import 'HomePage.dart';
import 'AboutUs.dart';
import 'AboutApp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Emotion Detection',
      debugShowCheckedModeBanner: false,
      home: Guide(),
    );
  }
}

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  int _selectedIndex = 4;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guide"),
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
      body: PlaceholderScreen(),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is a placeholder screen',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}