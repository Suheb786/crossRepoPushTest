import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:domain/usecase/account_setting/get_profile_info/get_profile_info_usecase.dart';
import 'package:domain/usecase/account_setting/upload_profile_image/delete_profile_image_usecase.dart';
import 'package:domain/usecase/account_setting/upload_profile_image/upload_profile_image_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:domain/usecase/user/authenticate_bio_metric_usecase.dart';
import 'package:domain/usecase/user/check_bio_metric_support_use_case.dart';
import 'package:domain/usecase/user/disable_finger_print_usecase.dart';
import 'package:domain/usecase/user/enable_biometric_usecase.dart';
import 'package:domain/usecase/user/generate_key_pair_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AccountSettingPageViewModel extends BasePageViewModel {
  final GetProfileInfoUseCase _getProfileInfoUseCase;
  final UploadDocumentUseCase _uploadDocumentUseCase;

  final CheckBioMetricSupportUseCase _checkBioMetricSupportUseCase;

  final AuthenticateBioMetricUseCase _authenticateBioMetricUseCase;

  final GenerateKeyPairUseCase _generateKeyPairUseCase;

  final EnableBiometricUseCase _enableBiometricUseCase;

  final UploadProfileImageUseCase _uploadProfileImageUseCase;

  final DisableFingerPrintUseCase _disableFingerPrintUseCase;

  final DeleteProfileImageUseCase _deleteProfileImageUseCase;

  ///cupertino switch value subject
  final BehaviorSubject<bool> _switchSubject = BehaviorSubject();

  Stream<bool> get switchValue => _switchSubject.stream;

  ///selected image subject
  final BehaviorSubject<String> _selectedImageSubject = BehaviorSubject.seeded('');

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  String selectedProfile = '';

  String mobile = '';

  ///upload profile
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest = PublishSubject();

  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream => _uploadProfilePhotoResponse.stream;

  /// check whether biometric is supported or not request
  PublishSubject<CheckBioMetricSupportUseCaseParams> _checkBioMetricRequest = PublishSubject();

  /// check whether biometric is supported or not response
  BehaviorSubject<Resource<bool>> _checkBioMetricResponse = BehaviorSubject();

  /// check whether biometric is supported or not response stream
  Stream<Resource<bool>> get checkBioMetricStream => _checkBioMetricResponse.stream;

  /// authenticate using biometric request
  PublishSubject<AuthenticateBioMetricUseCaseParams> _authenticateBioMetricRequest = PublishSubject();

  /// authenticate using biometric response
  PublishSubject<Resource<bool>> _authenticateBioMetricResponse = PublishSubject();

  /// authenticate using biometric response stream
  Stream<Resource<bool>> get authenticateBioMetricStream => _authenticateBioMetricResponse.stream;

  /// get profile info  request
  PublishSubject<GetProfileInfoUseCaseParams> _getProfileInfoRequest = PublishSubject();

  /// get profile info response
  PublishSubject<Resource<ProfileInfoResponse>> _getProfileInfoResponse = PublishSubject();

  /// get profile info response stream
  Stream<Resource<ProfileInfoResponse>> get getProfileInfoStream => _getProfileInfoResponse.stream;

  /// generate key pair request
  PublishSubject<GenerateKeyPairUseCaseParams> _generateKeyPairRequest = PublishSubject();

  /// generate key pair response
  PublishSubject<Resource<GenerateKeyPairResponse>> _generateKeyPairResponse = PublishSubject();

  /// generate key pair response stream
  Stream<Resource<GenerateKeyPairResponse>> get generateKeyPairStream => _generateKeyPairResponse.stream;

  /// enable biometric request
  PublishSubject<EnableBiometricUseCaseParams> _enableBiometricRequest = PublishSubject();

  /// enable biometric response
  PublishSubject<Resource<bool>> _enableBiometricResponse = PublishSubject();

  /// enable biometric response stream
  Stream<Resource<bool>> get enableBiometricStream => _enableBiometricResponse.stream;

  ///upload profile image
  PublishSubject<UploadProfileImageUseCaseParams> _uploadProfileImageRequest = PublishSubject();

  PublishSubject<Resource<bool>> _uploadProfileImageResponse = PublishSubject();

  Stream<Resource<bool>> get uploadProfileImageStream => _uploadProfileImageResponse.stream;

  ///disable finger print
  PublishSubject<DisableFingerPrintUseCaseParams> _disableFingerPrintRequest = PublishSubject();

  PublishSubject<Resource<bool>> _disableFingerPrintResponse = PublishSubject();

  Stream<Resource<bool>> get disableFingerPrintStream => _disableFingerPrintResponse.stream;

  ///delete profile image usecase
  PublishSubject<DeleteProfileImageUseCaseParams> _deleteProfileImageRequest = PublishSubject();

  PublishSubject<Resource<bool>> _deleteProfileImageResponse = PublishSubject();

  Stream<Resource<bool>> get deleteProfileImageStream => _deleteProfileImageResponse.stream;

  AccountSettingPageViewModel(
      this._uploadDocumentUseCase,
      this._checkBioMetricSupportUseCase,
      this._authenticateBioMetricUseCase,
      this._getProfileInfoUseCase,
      this._generateKeyPairUseCase,
      this._enableBiometricUseCase,
      this._uploadProfileImageUseCase,
      this._disableFingerPrintUseCase,
      this._deleteProfileImageUseCase) {
    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
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

    _getProfileInfoRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _getProfileInfoUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _getProfileInfoResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _generateKeyPairRequest.listen((value) {
      RequestManager(value, createCall: () => _generateKeyPairUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _generateKeyPairResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _enableBiometricRequest.listen((value) {
      RequestManager(value, createCall: () => _enableBiometricUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enableBiometricResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _uploadProfileImageRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadProfileImageUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _uploadProfileImageResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _disableFingerPrintRequest.listen((value) {
      RequestManager(value, createCall: () => _disableFingerPrintUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _disableFingerPrintResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _deleteProfileImageRequest.listen((value) {
      RequestManager(value, createCall: () => _deleteProfileImageUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _deleteProfileImageResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
    getProfileDetails();
  }

  void deleteProfileImage(dynamic image) {
    if (image != null && image != '') {
      _deleteProfileImageRequest.safeAdd(DeleteProfileImageUseCaseParams());
    }
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest.safeAdd(UploadDocumentUseCaseParams(documentType: type));
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
      AuthenticateBioMetricUseCaseParams(title: title, localisedReason: localisedReason),
    );
  }

  ///get profile details
  void getProfileDetails() {
    _getProfileInfoRequest.safeAdd(GetProfileInfoUseCaseParams());
  }

  void generateKeyPair() {
    _generateKeyPairRequest.safeAdd(GenerateKeyPairUseCaseParams());
  }

  void enableBiometric() {
    _enableBiometricRequest.safeAdd(EnableBiometricUseCaseParams());
  }

  void uploadProfileImage() {
    _uploadProfileImageRequest.safeAdd(UploadProfileImageUseCaseParams(imagePath: selectedProfile));
  }

  void disableFingerPrint() {
    _disableFingerPrintRequest.safeAdd(DisableFingerPrintUseCaseParams());
  }

  @override
  void dispose() {
    _checkBioMetricRequest.close();
    _checkBioMetricResponse.close();
    _authenticateBioMetricRequest.close();
    _authenticateBioMetricResponse.close();
    _getProfileInfoRequest.close();
    _getProfileInfoResponse.close();
    super.dispose();
  }
}
