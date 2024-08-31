import 'package:flutter/material.dart';

class PhotoClickedWidget extends StatelessWidget {
  final bool photoClicked;
  final VoidCallback togglePhotoClicked;
  final VoidCallback capturePhoto;
  final VoidCallback pickFromGallery;
  final VoidCallback flipCamera;

  const PhotoClickedWidget({
    super.key,
    required this.photoClicked,
    required this.togglePhotoClicked,
    required this.capturePhoto,
    required this.pickFromGallery,
    required this.flipCamera,
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
          const SizedBox(width: 190),
          Tooltip(
            message: 'Select',
            child: IconButton(
              onPressed: togglePhotoClicked,
              icon: const Icon(Icons.check, size: 40),
            ),
          ),
        ],
      );
    } else {),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Tooltip(
                message: 'Flip Camera',
                child: IconButton(
                  onPressed: flipCamera,
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
