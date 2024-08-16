// https://github.com/darshanvaru/Mood-Detector.git

import 'package:flutter/material.dart';
import 'Widgets/AppDrawer.dart';
import 'MainCamera.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _photoClicked = false;
  final int _selectedIndex = 0;

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
      drawer: AppDrawer(selectedIndex: _selectedIndex),
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
              alignment: const Alignment(0, 0),
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