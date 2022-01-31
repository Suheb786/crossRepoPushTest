import 'dart:async';

import 'package:domain/constants/error_types.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/model/user/biometric_login/get_cipher_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/infobip_audio/save_user_usecase.dart';
import 'package:domain/usecase/kyc/check_kyc_status_usecase.dart';
import 'package:domain/usecase/user/android_login_usecase.dart';
import 'package:domain/usecase/user/authenticate_bio_metric_usecase.dart';
import 'package:domain/usecase/user/check_bio_metric_support_use_case.dart';
import 'package:domain/usecase/user/get_cipher_usecase.dart';
import 'package:domain/usecase/user/iphone_login_usecase.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BasePageViewModel {
  final LoginUseCase _loginUseCase;
  final CheckKYCStatusUseCase _kycStatusUseCase;
  final GetCipherUseCase _getCipherUseCase;
  final AndroidLoginUseCase _androidLoginUseCase;
  final IphoneLoginUseCase _iphoneLoginUseCase;
  final CheckBioMetricSupportUseCase _checkBioMetricSupportUseCase;
  final AuthenticateBioMetricUseCase _authenticateBioMetricUseCase;
  final SaveUserUseCase _saveUserUseCase;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final GlobalKey<AppTextFieldState> emailKey =
      GlobalKey(debugLabel: "login_email");
  final GlobalKey<AppTextFieldState> passwordKey =
      GlobalKey(debugLabel: "login_password");

  PublishSubject<LoginUseCaseParams> _loginRequest = PublishSubject();

  PublishSubject<Resource<User>> _loginResponse = PublishSubject();

  PublishSubject<SaveUserUseCaseParams> _saveUserRequestSubject =
      PublishSubject();

  PublishSubject<Resource<bool>> _saveuserResponseSubject = PublishSubject();

  Stream<Resource<User>> get loginStream => _loginResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///kyc status request
  PublishSubject<CheckKYCStatusUseCaseParams> _kycStatusRequest =
      PublishSubject();

  ///kyc status response
  PublishSubject<Resource<CheckKycResponse>> _kycStatusResponse =
      PublishSubject();

  ///kyc status response stream
  Stream<Resource<CheckKycResponse>> get kycStatusStream =>
      _kycStatusResponse.stream;

  ///get cipher usecase
  PublishSubject<GetCipherUseCaseParams> _getCipherRequest = PublishSubject();

  PublishSubject<Resource<GetCipherResponse>> _getCipherResponse =
      PublishSubject();

  Stream<Resource<GetCipherResponse>> get getCipherStream =>
      _getCipherResponse.stream;

  BehaviorSubject<bool> _fingerPrintShowRequest = BehaviorSubject.seeded(false);

  Stream<bool> get fingerPrintShowStream => _fingerPrintShowRequest.stream;

  ///android login
  PublishSubject<AndroidLoginUseCaseParams> _androidLoginRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _androidLoginResponse = PublishSubject();

  Stream<Resource<bool>> get androidLoginStream => _androidLoginResponse.stream;

  ///iphone login
  PublishSubject<IphoneLoginUseCaseParams> _iphoneLoginRequest =
      PublishSubject();

  PublishSubject<Resource<User>> _iphoneLoginResponse = PublishSubject();

  Stream<Resource<User>> get iphoneLoginStream => _iphoneLoginResponse.stream;

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

  LoginViewModel(
      this._loginUseCase,
      this._kycStatusUseCase,
      this._getCipherUseCase,
      this._androidLoginUseCase,
      this._iphoneLoginUseCase,
      this._checkBioMetricSupportUseCase,
      this._authenticateBioMetricUseCase,
      this._saveUserUseCase) {
    _loginRequest.listen((value) {
      RequestManager(value,
              createCall: () => _loginUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _loginResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.ERROR) {
          if (event.appError!.type == ErrorType.EMPTY_EMAIL ||
              event.appError!.type == ErrorType.INVALID_EMAIL) {
            emailKey.currentState!.isValid = false;
          }
          if (event.appError!.type == ErrorType.EMPTY_PASSWORD) {
            passwordKey.currentState!.isValid = false;
          }
          showErrorState();
        }
      });
    });

    _kycStatusRequest.listen((value) {
      RequestManager(value,
              createCall: () => _kycStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _kycStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getCipherRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getCipherUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        //updateLoader();
        _getCipherResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          //showToastWithError(event.appError!);
        }
      });
    });

    _androidLoginRequest.listen((value) {
      RequestManager(value,
              createCall: () => _androidLoginUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _androidLoginResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _iphoneLoginRequest.listen((value) {
      RequestManager(value,
              createCall: () => _iphoneLoginUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _iphoneLoginResponse.safeAdd(event);
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

    _saveUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _saveUserUseCase.execute(params: value);
      }).asFlow().listen((event) {
        _saveuserResponseSubject.safeAdd(event);
      });
    });

    //getCipher();
    //getCurrentUserStream();
  }

  void checkBiometric() {
    _checkBioMetricRequest.add(
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

  void fingerPrintShow(bool value) {
    _fingerPrintShowRequest.safeAdd(value);
  }

  void validateEmail() {
    _loginRequest.safeAdd(LoginUseCaseParams(
        email: emailController.text, password: passwordController.text));
  }

  void checkKycStatus() {
    _kycStatusRequest.safeAdd(CheckKYCStatusUseCaseParams());
  }

  void androidLogin({required String cipher}) {
    _androidLoginRequest.safeAdd(AndroidLoginUseCaseParams(cipher: cipher));
  }

  void iphoneLogin({required String cipher}) {
    _iphoneLoginRequest.safeAdd(IphoneLoginUseCaseParams(cipher: cipher));
  }

  void validate() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void getCipher() {
    _getCipherRequest.safeAdd(GetCipherUseCaseParams());
  }

  void saveUserData() {
    _saveUserRequestSubject.safeAdd(SaveUserUseCaseParams());
  }

  @override
  void dispose() {
    _loginRequest.close();
    _loginResponse.close();
    _showButtonSubject.close();
    _kycStatusRequest.close();
    _kycStatusResponse.close();
    super.dispose();
  }
}
