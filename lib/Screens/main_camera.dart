// main_camera.dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../Widgets/photo_clicked_widget.dart';
import '../Widgets/camera_help_dialog.dart';
import '../services/camera_service.dart';

class MainCamera extends StatefulWidget {
  const MainCamera({super.key});

  @override
  MainCameraState createState() => MainCameraState();
}

class MainCameraState extends State<MainCamera> {
  final CameraService _cameraService = CameraService();
  bool _photoClicked = false;
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

  void _togglePhotoClicked() {
    setState(() {
      _photoClicked = !_photoClicked;
      _capturedImage = null;
    });
  }

  bool _isFrontCamera() {
    return cameras![_selectedCameraIndex].lensDirection == CameraLensDirection.front;
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
          SnackBar(
            content: Text('Error capturing photo: $e'),
            backgroundColor: Colors.red,
          ),
        );
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

  void _flipCamera() async {
    if (cameras != null && cameras!.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras!.length;
      await _cameraService.initializeCamera(cameras!, _selectedCameraIndex);
      if (mounted) {
        setState(() {});
      }
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
                  return const CameraHelpDialog();
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
