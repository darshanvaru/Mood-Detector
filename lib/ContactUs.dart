import 'package:flutter/material.dart';
import 'AboutApp.dart';
import 'AboutUs.dart';
import 'Guide.dart';
import 'HomePage.dart';

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
      home: HomePage(),
    );
  }
}

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  int _selectedIndex = 1;

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
        page = const HomePage();
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
        title: const Text("Contact Us"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              Container(
                padding:
                const EdgeInsets.all(10.0), // Add padding to the container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Your Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        hintText: 'Your Name',
                      ),
                    ),
                  ],
                ),
              ),
              // Subject Field
              Container(
                padding:
                const EdgeInsets.all(10.0), // Add padding to the container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Subject',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        hintText: 'Subject of Mail',
                      ),
                    ),
                  ],
                ),
              ),
              // Message Field
              Container(
                padding:
                const EdgeInsets.all(10.0), // Add padding to the container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Your Message',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      maxLines: 10,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        hintText: 'Message',
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlaceholderScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white70,
                      elevation: 5, // Elevation
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(
                            color: Colors.black12,
                          )),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0), // Padding
                    ),
                    child: const Text('Send'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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