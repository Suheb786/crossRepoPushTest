import 'package:camera/camera.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class CaptureViewModel extends BasePageViewModel {
  CameraController? cameraController;

  PublishSubject<bool> _cameraControllerInitializer = PublishSubject();

  Stream<bool> get cameraControllerInitializerStream =>
      _cameraControllerInitializer.stream;

  void initCamera(List<CameraDescription> cameras) {
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController!.initialize().then((_) {
      _cameraControllerInitializer.safeAdd(true);
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController? controller = cameraController;

    if (controller!.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _cameraControllerInitializer.close();
    cameraController!.dispose();
    super.dispose();
  }
}
