import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../Widgets/photo_clicked_widget.dart';

class MainCamera extends StatefulWidget {
  const MainCamera({super.key});

  @override
  MainCameraState createState() => MainCameraState();
}

class MainCameraState extends State<MainCamera> {
  bool _photoClicked = false;
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  XFile? _capturedImage;
  int _selectedCameraIndex = 0;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras![_selectedCameraIndex],
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  void _togglePhotoClicked() {
    setState(() {
      _photoClicked = !_photoClicked;
      _capturedImage = null;
    });
  }

  Future<void> _capturePhoto() async {
    try {
      await _initializeControllerFuture;
      final imageFile = await _cameraController.takePicture();

      // Load the image using the image package
      final image = img.decodeImage(File(imageFile.path).readAsBytesSync());
      if (image != null) {
        // Flip the image horizontally
        final flippedImage = img.flipHorizontal(image);

        // Save the flipped image to a new file
        final flippedImagePath = '${Directory.systemTemp.path}/flipped_image.jpg';
        File(flippedImagePath).writeAsBytesSync(img.encodeJpg(flippedImage));

        setState(() {
          _capturedImage = XFile(flippedImagePath);
          _photoClicked = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }


  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _capturedImage = XFile(pickedFile.path);
        _photoClicked = true;
      });
    }
  }

  void _flipCamera() async {
    if (cameras != null && cameras!.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras!.length;
      _cameraController = CameraController(
        cameras![_selectedCameraIndex],
        ResolutionPreset.high,
      );

      _initializeControllerFuture = _cameraController.initialize();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
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
                          'If possible, then remove goggles if there is any.\n\n'
                          'You can visit the Guide page from the home screen for more information.',
                      textAlign: TextAlign.left,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
          Expanded(
            child: _photoClicked && _capturedImage != null
                ? Center(
              child: Container(
                padding: const EdgeInsets.all(10.0), // Adjust padding for the floating effect
                margin: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust margin for side spacing
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.file(
                    File(_capturedImage!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
                : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 80,
              child: PhotoClickedWidget(
                photoClicked: _photoClicked,
                togglePhotoClicked: _togglePhotoClicked,
                capturePhoto: _capturePhoto,
                pickFromGallery: _pickFromGallery,
                flipCamera: _flipCamera,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
