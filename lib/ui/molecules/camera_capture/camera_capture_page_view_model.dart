import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class CameraCapturePageViewModel extends BasePageViewModel {
  CameraController? cameraController;

  PublishSubject<bool> _cameraControllerInitializer = PublishSubject();
  PublishSubject<String> _filePathRequest = PublishSubject();

  Stream<String> get filePathResponseStream => _filePathRequest.stream;

  CameraCapturePageViewModel() {}

  Stream<bool> get cameraControllerInitializerStream => _cameraControllerInitializer.stream;
  List<CameraDescription> cameras = [];

  int selectedCameraIndex = 0;

  void initCamera(List<CameraDescription> cameras, int selectedCameraType) {
    cameraController =
        CameraController(cameras[selectedCameraType], ResolutionPreset.medium, enableAudio: false);
    cameraController!.initialize().then((_) {
      _cameraControllerInitializer.safeAdd(true);
    });
  }

  void takePicture() async {
    final CameraController? controller = cameraController;

    if (controller!.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await controller.takePicture();
      uploadImage(file);
    } on CameraException catch (e) {
      debugPrint('$e');
    }
  }

  void uploadImage(XFile file) {
    _filePathRequest.safeAdd(file.path);
  }

  @override
  void dispose() {
    _cameraControllerInitializer.close();
    cameraController!.dispose();

    super.dispose();
  }
}
