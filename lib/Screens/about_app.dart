import 'package:flutter/material.dart';

import '../Widgets/app_bottom_nav_bar.dart';
import 'home_page.dart';

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
      home: AboutApp(),
    );
  }
}

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        title: const Text("About App"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(
              'Our app, "Mood Detector," is designed to recognize and interpret emotions from facial expressions. By simply capturing a photo, our app processes the image using advanced machine learning models to determine the emotion conveyed. Whether you\'re curious about how you or others might be feeling, or you\'re looking to incorporate emotional analysis into your routine, Mood Detector offers a seamless and engaging experience. The app features a clean and user-friendly interface, making it easy to navigate through different functionalities, such as taking photos, viewing results, and exploring additional resources.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(
        selectedIndex: 1,
        selectedSettingIndex: 3,
      ),
    );
  }
}