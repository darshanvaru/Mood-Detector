import 'package:flutter/material.dart';
import '../Widgets/AppBottomNavBar.dart';

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
      home: AboutUs(),
    );
  }
}

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'We are a dedicated team of developers and UI/UX enthusiasts passionate about creating innovative solutions that enhance daily life. Our expertise spans across various platforms, and we have a strong focus on Android and Flutter development. With a commitment to quality and user satisfaction, we strive to deliver apps that not only meet but exceed expectations. Our current project, Mood Detector, is a testament to our mission of merging technology with human emotions in a way that is accessible and impactful.',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: _selectedIndex),
    );
  }
}