import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  int _selectedCameraIndex = 1;
  List<CameraDescription>? cameras;
  FlashMode _flashMode = FlashMode.auto; // Default flash mode

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

  Future<void> _capturePhoto() async {
    try {
      final image = await _cameraService.capturePhoto();

      if (_selectedCameraIndex == 1) {
        final bytes = await image.readAsBytes();
        final flippedImage = await _flipImageHorizontally(bytes);

        // Save or use the flipped image
        setState(() {
          _capturedImage = XFile.fromData(flippedImage);
          _photoClicked = true;
        });
      } else {
        setState(() {
          _capturedImage = image;
          _photoClicked = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error capturing photo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<Uint8List> _flipImageHorizontally(Uint8List imageBytes) async {
    final image = await decodeImageFromList(imageBytes);
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromPoints(const Offset(0, 0), Offset(image.width.toDouble(), image.height.toDouble())));

    final paint = Paint();
    final matrix = Matrix4.identity()..translate(image.width.toDouble())..scale(-1.0, 1.0); // Flip horizontally

    canvas.transform(matrix.storage); // Move the transformation before drawing
    canvas.drawImage(image, Offset.zero, paint);

    final flippedImage = await recorder.endRecording().toImage(image.width, image.height);
    final byteData = await flippedImage.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
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

  void _toggleFlashMode() {
    setState(() {
      if (_flashMode == FlashMode.auto) {
        _flashMode = FlashMode.torch;
      } else if (_flashMode == FlashMode.torch) {
        _flashMode = FlashMode.off;
      } else {
        _flashMode = FlashMode.auto;
      }
      _cameraService.setFlashMode(_flashMode);
    });
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
          if(_selectedCameraIndex==0)
            IconButton(
            icon: Icon(
              _flashMode == FlashMode.auto
                  ? Icons.flash_auto
                  : _flashMode == FlashMode.torch
                  ? Icons.flash_on
                  : Icons.flash_off,
            ),
            onPressed: _toggleFlashMode,
          ),
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
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
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
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CameraPreview(_cameraService.cameraController),
                    ),
                  );
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
