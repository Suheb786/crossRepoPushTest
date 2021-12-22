import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:domain/usecase/user/authenticate_bio_metric_usecase.dart';
import 'package:domain/usecase/user/check_bio_metric_support_use_case.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class AccountSettingPageViewModel extends BasePageViewModel {
  final UploadDocumentUseCase _uploadDocumentUseCase;

  final CheckBioMetricSupportUseCase _checkBioMetricSupportUseCase;

  final AuthenticateBioMetricUseCase _authenticateBioMetricUseCase;

  ///cupertino switch value subject
  final BehaviorSubject<bool> _switchSubject = BehaviorSubject.seeded(false);

  Stream<bool> get switchValue => _switchSubject.stream;

  ///selected image subject
  final BehaviorSubject<String> _selectedImageSubject =
  BehaviorSubject.seeded('');

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  String selectedProfile = '';

  ///upload profile
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest =
  PublishSubject();

  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream =>
      _uploadProfilePhotoResponse.stream;

  /// check whether biometric is supported or not request
  PublishSubject<CheckBioMetricSupportUseCaseParams> _checkBioMetricRequest =
  PublishSubject();

  /// check whether biometric is supported or not response
  BehaviorSubject<Resource<bool>> _checkBioMetricResponse = BehaviorSubject();

  /// check whether biometric is supported or not response stream
  Stream<Resource<bool>> get checkBioMetricStream =>
      _checkBioMetricResponse.stream;

  /// authenticate using biometric request
  PublishSubject<AuthenticateBioMetricUseCaseParams>
  _authenticateBioMetricRequest = PublishSubject();

  /// authenticate using biometric response
  PublishSubject<Resource<bool>> _authenticateBioMetricResponse =
  PublishSubject();

  /// authenticate using biometric response stream
  Stream<Resource<bool>> get authenticateBioMetricStream =>
      _authenticateBioMetricResponse.stream;

  AccountSettingPageViewModel(this._uploadDocumentUseCase,
      this._checkBioMetricSupportUseCase, this._authenticateBioMetricUseCase) {
    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value,
          createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadProfilePhotoResponse.safeAdd(event.data!);
      });
    });

    _checkBioMetricRequest.listen((value) {
      RequestManager<bool>(
        value,
        createCall: () => _checkBioMetricSupportUseCase.execute(params: value),
      ).asFlow().listen((event) {
        _checkBioMetricResponse.safeAdd(event);
      });
    });

    _authenticateBioMetricRequest.listen((value) {
      RequestManager<bool>(
        value,
        createCall: () => _authenticateBioMetricUseCase.execute(params: value),
      ).asFlow().listen((event) {
        _authenticateBioMetricResponse.safeAdd(event);
      });
    });
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
  }

  void updateSwitchValue(bool value) {
    _switchSubject.safeAdd(value);
  }

  void checkBiometric() {
    print('called');
    _checkBioMetricRequest.safeAdd(
      CheckBioMetricSupportUseCaseParams(),
    );
  }

  /// Authenticate before set the biometric
  void authenticateBioMetric({String title: "", String localisedReason: ""}) {
    _authenticateBioMetricRequest.safeAdd(
      AuthenticateBioMetricUseCaseParams(
          title: title, localisedReason: localisedReason),
    );
  }

  @override
  void dispose() {
    _checkBioMetricRequest.close();
    _checkBioMetricResponse.close();
    _authenticateBioMetricRequest.close();
    _authenticateBioMetricResponse.close();
    super.dispose();
  }
}
