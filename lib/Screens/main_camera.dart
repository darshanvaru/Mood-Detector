import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import '../services/camera_service.dart';
import '../Widgets/photo_clicked_widget.dart';
import 'dart:io';

class MainCamera extends StatefulWidget {
  const MainCamera({super.key});

  @override
  MainCameraState createState() => MainCameraState();
}

class MainCameraState extends State<MainCamera> {
  bool _photoClicked = false;
  final CameraService _cameraService = CameraService();
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
    await _cameraService.initializeCamera(cameras!, _selectedCameraIndex);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _capturePhoto() async {
    try {
      final image = await _cameraService.capturePhoto();
      setState(() {
        _capturedImage = image;
        _photoClicked = true;
      });
    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Error! Please try again',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _togglePhotoClicked() {
    setState(() {
      _photoClicked = !_photoClicked;
      _capturedImage = null;
    });
  }

  void _flipCamera() async {
    if (cameras != null && cameras!.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras!.length;
      await _cameraService.initializeCamera(cameras!, _selectedCameraIndex);
      if (mounted) {
        setState(() {});
      }
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

  @override
  void dispose() {
    _cameraService.dispose();
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
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
              future: _cameraService.initializeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraService.cameraController);
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
