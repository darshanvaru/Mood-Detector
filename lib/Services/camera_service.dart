import 'package:camera/camera.dart';

class CameraService {
  late CameraController _cameraController;
  late Future<void> initializeControllerFuture;

  CameraController get cameraController => _cameraController;
  Future<void> get initializeFuture => initializeControllerFuture;

  Future<void> initializeCamera(List<CameraDescription> cameras, int selectedIndex) async {
    _cameraController = CameraController(
      cameras[selectedIndex],
      ResolutionPreset.high,
    );
    initializeControllerFuture = _cameraController.initialize();
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (cameraController.value.isInitialized) {
      await cameraController.setFlashMode(mode);
    }
  }

  Future<XFile> capturePhoto() async {
    await initializeControllerFuture;
    return _cameraController.takePicture();
  }

  void dispose() {
    _cameraController.dispose();
  }
}