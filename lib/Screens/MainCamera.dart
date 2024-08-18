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
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_sharp),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text(
                      'Please ensure you are in a well-lit environment for taking a photo. '
                      'Make sure your face is clearly visible. '
                      'If possible, then remove goggles if there is any \n\n'
                      'You can visit Guide page from home screen for more information',
                      textAlign: TextAlign.left,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Closes the dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Expanded(child: Placeholder()),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                  height: 120,
                  child: PhotoClickedWidget(
                      photoClicked: _photoClicked,
                      togglePhotoClicked: _togglePhotoClicked))
          ),
        ],
      ),
    );
  }
}