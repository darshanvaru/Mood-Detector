import 'package:flutter/material.dart';
import 'Screens/home_page.dart';
// import 'temp.dart';

void main() => runApp(const MyApp());

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
