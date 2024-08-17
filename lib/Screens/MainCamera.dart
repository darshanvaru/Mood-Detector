import 'package:flutter/material.dart';
import '../Widgets/PhotoClickedWidget.dart';

class MainCamera extends StatefulWidget {
  const MainCamera({super.key});

  @override
  _MainCameraState createState() => _MainCameraState();
}

class _MainCameraState extends State<MainCamera> {
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
        title: const Text('MainCamera'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Expanded(child: Placeholder()),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 140,
                child: PhotoClickedWidget(photoClicked: _photoClicked, togglePhotoClicked: _togglePhotoClicked)
            )
          ),
        ],
      ),
    );
  }
}
