import 'dart:async';

import 'package:data/helper/secure_storage_helper.dart';
import 'package:domain/constants/enum/language_enum.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/model/user/biometric_login/android_login_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/infobip_audio/init_infobip_message_usecase.dart';
import 'package:domain/usecase/kyc/check_kyc_status_usecase.dart';
import 'package:domain/usecase/user/android_login_usecase.dart';
import 'package:domain/usecase/user/authenticate_bio_metric_usecase.dart';
import 'package:domain/usecase/user/check_bio_metric_support_use_case.dart';
import 'package:domain/usecase/user/check_version_update_usecase.dart';
import 'package:domain/usecase/user/get_current_user_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class LoginLandingPageViewModel extends BasePageViewModel {
  final CheckKYCStatusUseCase _kycStatusUseCase;
  final AndroidLoginUseCase _androidLoginUseCase;
  final CheckBioMetricSupportUseCase _checkBioMetricSupportUseCase;
  final AuthenticateBioMetricUseCase _authenticateBioMetricUseCase;
  final CheckVersionUpdateUseCase _checkVersionUpdateUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final InfobipMessagePluginUseCase _infobipMessagePluginUseCase;

  ///-----------------------Language switch value------------------///

  BehaviorSubject<bool> _switchRequest = BehaviorSubject.seeded(true);

  Stream<bool> get switchStream => _switchRequest.stream;

  void updateSwitchValue(bool value) {
    _switchRequest.safeAdd(value);
  }

  List<String> languageValue = ['ENG', 'عربي'];

  void setLanguage(LanguageEnum language, BuildContext context) {
    ProviderScope.containerOf(context).read(appViewModel).toggleLocale(language);
    setLanguageToStorage(language);
  }

  setLanguageToStorage(LanguageEnum languageEnum) async {
    await SecureStorageHelper.instance.saveUserSelectedLanguageToStorage(language: languageEnum.toString());
  }

  getLanguageFromStorage(BuildContext context) async {
    LanguageEnum? selectedLanguage = await SecureStorageHelper.instance.getUserSelectedLanguageFromStorage();
    if (selectedLanguage != null) {
      ProviderScope.containerOf(context).read(appViewModel).toggleLocale(selectedLanguage);
      updateSwitchValue(selectedLanguage == LanguageEnum.ENGLISH ? true : false);
    }
  }

  ///-----------------------Language switch value------------------///

  ///-----------------------KYC status ---------------------------///

  PublishSubject<CheckKYCStatusUseCaseParams> _kycStatusRequest = PublishSubject();

  PublishSubject<Resource<CheckKycResponse>> _kycStatusResponse = PublishSubject();

  Stream<Resource<CheckKycResponse>> get kycStatusStream => _kycStatusResponse.stream;

  void checkKycStatus() {
    _kycStatusRequest.safeAdd(CheckKYCStatusUseCaseParams());
  }

  ///-----------------------KYC status ---------------------------///

  ///---------------------- Android Login ------------------------///
  PublishSubject<AndroidLoginUseCaseParams> _androidLoginRequest = PublishSubject();

  PublishSubject<Resource<AndroidLoginResponse>> _androidLoginResponse = PublishSubject();

  Stream<Resource<AndroidLoginResponse>> get androidLoginStream => _androidLoginResponse.stream;

  void androidLogin({required String cipher}) {
    _androidLoginRequest.safeAdd(AndroidLoginUseCaseParams(cipher: cipher));
  }

  ///---------------------- Android Login ------------------------///

  /// ----------------------Check Biometric Support -------------///

  PublishSubject<CheckBioMetricSupportUseCaseParams> _checkBioMetricRequest = PublishSubject();

  BehaviorSubject<Resource<bool>> _checkBioMetricResponse = BehaviorSubject();

  Stream<Resource<bool>> get checkBioMetricStream => _checkBioMetricResponse.stream;

  void checkBiometric() {
    _checkBioMetricRequest.add(
      CheckBioMetricSupportUseCaseParams(),
    );
  }

  /// ----------------------Check Biometric Support -------------///

  /// ----------------------Authenticate Biometric -------------///

  PublishSubject<AuthenticateBioMetricUseCaseParams> _authenticateBioMetricRequest = PublishSubject();

  PublishSubject<Resource<bool>> _authenticateBioMetricResponse = PublishSubject();

  Stream<Resource<bool>> get authenticateBioMetricStream => _authenticateBioMetricResponse.stream;

  void authenticateBioMetric({String title = "", String localisedReason = ""}) {
    _authenticateBioMetricRequest.safeAdd(
      AuthenticateBioMetricUseCaseParams(title: title, localisedReason: localisedReason),
    );
  }

  /// ----------------------Authenticate Biometric -------------///

  String mobileNumber = '';
  String mobileCode = '';
  String applicationId = '';

  /// ----------------------version Update -------------///
  PublishSubject<CheckVersionUpdateUseCaseParams> _checkVersionUpdateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _checkVersionUpdateResponse = PublishSubject();

  Stream<Resource<bool>> get checkVersionUpdateStream => _checkVersionUpdateResponse.stream;

  void checkVersionUpdate({String? clear}) {
    _checkVersionUpdateRequest.safeAdd(CheckVersionUpdateUseCaseParams(clear: clear!));
  }

  /// ----------------------version Update -------------///

  /// ----------------------Current User data -------------///
  final PublishSubject<GetCurrentUserUseCaseParams> _currentUserRequestSubject = PublishSubject();

  final PublishSubject<Resource<User>> _currentUserResponseSubject = PublishSubject();

  Stream<Resource<User>> get currentUser => _currentUserResponseSubject.stream;

  void getCurrentUser() {
    _currentUserRequestSubject.add(GetCurrentUserUseCaseParams());
  }

  /// ----------------------Current User data -------------///

  /// ----------------------Register Infobip Service-------------///
  PublishSubject<InfobipMessagePluginUseCaseParams> _initInfobipMessageRequestSubject = PublishSubject();

  void initInfobipMobileMessagePlugin() async {
    if (!AppConstantsUtils.isInfobipRegistered) {
      _initInfobipMessageRequestSubject.safeAdd(InfobipMessagePluginUseCaseParams());
    }
  }

  /// ----------------------Register Infobip Service-------------///

  bool isBiometricDialogShown = false;

  LoginLandingPageViewModel(
      this._kycStatusUseCase,
      this._androidLoginUseCase,
      this._checkBioMetricSupportUseCase,
      this._authenticateBioMetricUseCase,
      this._checkVersionUpdateUseCase,
      this._getCurrentUserUseCase,
      this._infobipMessagePluginUseCase) {
    _kycStatusRequest.listen((value) {
      RequestManager(value, createCall: () => _kycStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _kycStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _androidLoginRequest.listen((value) {
      RequestManager(value, createCall: () => _androidLoginUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _androidLoginResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
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

    _checkVersionUpdateRequest.listen((value) {
      RequestManager(value, createCall: () => _checkVersionUpdateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _checkVersionUpdateResponse.safeAdd(event);
      });
    });

    _currentUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _getCurrentUserUseCase.execute(params: value))
          .asFlow()
          .listen((event) async {
        _currentUserResponseSubject.add(event);
      });
    });

    _initInfobipMessageRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _infobipMessagePluginUseCase.execute(params: value);
      }).asFlow().listen((event) {
        if (event.status == Status.SUCCESS) {
          AppConstantsUtils.isInfobipRegistered = true;
        }
      });
    });


  }

  @override
  void dispose() {
    _kycStatusRequest.close();
    _kycStatusResponse.close();
    _initInfobipMessageRequestSubject.close();
    _currentUserRequestSubject.close();
    _currentUserResponseSubject.close();
    _checkVersionUpdateRequest.close();
    _checkVersionUpdateResponse.close();
    _authenticateBioMetricRequest.close();
    _authenticateBioMetricResponse.close();
    _checkBioMetricRequest.close();
    _checkBioMetricResponse.close();
    _androidLoginRequest.close();
    _androidLoginResponse.close();
    _kycStatusRequest.close();
    _kycStatusResponse.close();

    super.dispose();
  }
}
