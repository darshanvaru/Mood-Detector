// https://github.com/darshanvaru/Mood-Detector
import 'package:flutter/material.dart';

import '../Widgets/app_bottom_nav_bar.dart';
import 'main_camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _photoClicked = false;

  void _togglePhotoClicked() {
    setState(() {
      _photoClicked = !_photoClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          'Emotion Eye',
          style: TextStyle(
            fontFamily: 'Proximal Nova',
            fontSize: 24.0,
          ),
        )),
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
              alignment: const Alignment(0, 0),
              children: <Widget>[
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],
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
                            builder: (context) => const MainCamera()
                        ));
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
      bottomNavigationBar: const AppBottomNavBar(selectedIndex: 0),
    );
  }
}