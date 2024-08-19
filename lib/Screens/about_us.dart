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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) =>
                  false, // This condition removes all routes
            );
          },
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        title: const Text("About Us"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(
              'We are a passionate and dynamic team of three — Darshan Varu, Smit Thakker, and Parv Ravasiya—currently in our 5th semester of BE in Computer Engineering. '
              'Our journey in the field of technology has been driven by a shared love for innovation and a deep interest in how technology can enhance daily life. '
              'Each member of our team brings unique strengths and perspectives, allowing us to tackle challenges from multiple angles and develop comprehensive solutions.\n\n'
              'Our expertise covers a broad spectrum of platforms, with a particular emphasis on Android and Flutter development. '
              'We believe in the power of design and user experience, and our work reflects a commitment to creating intuitive, aesthetically pleasing interfaces that resonate with users. '
              'Whether it\'s developing robust backend systems or crafting pixel-perfect UI designs, we approach every project with meticulous attention to detail and a relentless drive for excellence.\n\n'
              'Our current project, Mood Detector, exemplifies our mission to merge technology with human emotions, making advanced technology accessible and impactful in everyday life. '
              'This project is more than just an app; it’s an exploration of how technology can understand and respond to human feelings, creating a more empathetic and connected world. '
              'We are driven by the belief that technology should not only solve problems but also enhance the human experience in meaningful ways.\n\n'
              'As we continue to grow and learn, our focus remains on pushing the boundaries of what’s possible, delivering solutions that not only meet but exceed expectations. '
              'We are excited to see where our journey takes us and are committed to making a positive impact through our work.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(
        selectedIndex: 1,
        selectedSettingIndex: 2,
      ),
    );
  }
}