import 'package:flutter/material.dart';

class PhotoClickedWidget extends StatelessWidget {
  final bool photoClicked;
  final VoidCallback togglePhotoClicked;

  const PhotoClickedWidget({
    Key? key,
    required this.photoClicked,
    required this.togglePhotoClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (photoClicked) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: 'Retake',
            child: IconButton(
              onPressed: togglePhotoClicked,
              icon: const Icon(Icons.replay, size: 40),
            ),
          ),
          const SizedBox(width: 16), // Adjust width if needed
          Tooltip(
            message: 'Select',
            child: IconButton(
              onPressed: togglePhotoClicked,
              icon: const Icon(Icons.check, size: 40),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 16, // Adjust based on design needs
            child: Tooltip(
              message: 'Media',
              child: IconButton(
                onPressed: () {
                  // Handle media selection here
                },
                icon: const Icon(Icons.photo_library, size: 45),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: togglePhotoClicked,
            shape: const CircleBorder(),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.camera_alt_rounded, size: 50),
          ),
          Positioned(
            right: 16, // Adjust based on design needs
            child: Tooltip(
              message: 'Flip Camera',
              child: IconButton(
                onPressed: () {
                  // Handle camera flip
                },
                icon: const Icon(Icons.cameraswitch_rounded, size: 45),
              ),
            ),
          ),
        ],
      );
    }
  }
}
