import 'package:flutter/material.dart';

class PhotoClickedWidget extends StatelessWidget {
  final bool photoClicked;
  final VoidCallback togglePhotoClicked;

  const PhotoClickedWidget({
    super.key,
    required this.photoClicked,
    required this.togglePhotoClicked,
  });

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
          const SizedBox(width: 16),
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
            left: 16,
            child: Tooltip(
              message: 'Media',
              child: IconButton(
                onPressed: () {
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
            right: 16,
            child: Tooltip(
              message: 'Flip Camera',
              child: IconButton(
                onPressed: () {
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
