import 'package:camera/camera.dart';
import 'package:domain/usecase/user/upload_selfie_image_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class CaptureViewModel extends BasePageViewModel {
  CameraController? cameraController;
  final UploadSelfieImageUseCase _selfieImageUseCase;

  PublishSubject<bool> _cameraControllerInitializer = PublishSubject();
  PublishSubject<UploadSelfieImageUseCaseParams> _uploadImageRequest =
      PublishSubject();
  PublishSubject<Resource<bool>> _uploadImageResponse = PublishSubject();

  Stream<Resource<bool>> get uploadImageResponseStream =>
      _uploadImageResponse.stream;

  CaptureViewModel(this._selfieImageUseCase) {
    _uploadImageRequest.listen((value) {
      RequestManager(value,
              createCall: () => _selfieImageUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadImageResponse.safeAdd(event);
      });
    });
  }

  Stream<bool> get cameraControllerInitializerStream =>
      _cameraControllerInitializer.stream;

  void initCamera(List<CameraDescription> cameras) {
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
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
      cameraController!.pausePreview();
      XFile file = await controller.takePicture();
      uploadImage(file);
    } on CameraException catch (e) {
      print(e);
    }
  }

  void uploadImage(XFile file) {
    _uploadImageRequest
        .safeAdd(UploadSelfieImageUseCaseParams(imagePath: file.path));
  }

  @override
  void dispose() {
    _cameraControllerInitializer.close();
    cameraController!.dispose();
    _uploadImageRequest.close();
    _uploadImageResponse.close();
    super.dispose();
  }
}
