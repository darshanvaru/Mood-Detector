import 'package:flutter/material.dart';

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
                child: photoClicked())
          ),
        ],
      ),
    );
  }

  Widget photoClicked() {
    if (_photoClicked) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: 'Retake',
            child: IconButton(
              onPressed: _togglePhotoClicked,
              icon: const Icon(Icons.replay, size: 40),
            ),
          ),
          SizedBox(width: 180),
          Tooltip(
            message: 'Select',
            child: IconButton(
              onPressed: _togglePhotoClicked, // Modify this if select action is different
              icon: const Icon(Icons.check, size: 40),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Tooltip(
                message: 'Media',
                child: IconButton(
                  onPressed: () {
                    // Handle media selection here
                  },
                  icon: const Icon(Icons.photo_library, size: 40),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: FloatingActionButton(
              onPressed: _togglePhotoClicked,
              shape: const CircleBorder(),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.camera_alt_rounded, size: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Align(
              alignment: Alignment.centerRight,
              child: Tooltip(
                message: 'Flip Camera',
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.cameraswitch_rounded, size: 40),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
