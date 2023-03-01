import 'dart:async';
import 'dart:isolate';

import 'package:data/helper/secure_storage_helper.dart';
import 'package:domain/constants/enum/language_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/model/user/biometric_login/android_login_response.dart';
import 'package:domain/model/user/biometric_login/get_cipher_response.dart';
import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/bill_payment/account_upload_usecase.dart';
import 'package:domain/usecase/bill_payment/register_customer_usecase.dart';
import 'package:domain/usecase/bill_payment/regiter_account_usecase.dart';
import 'package:domain/usecase/device_change/send_otp_token_device_change_usecase.dart';
import 'package:domain/usecase/device_change/send_otp_token_email_usecase.dart';
import 'package:domain/usecase/infobip_audio/init_infobip_message_usecase.dart';
import 'package:domain/usecase/kyc/check_kyc_status_usecase.dart';
import 'package:domain/usecase/user/android_login_usecase.dart';
import 'package:domain/usecase/user/authenticate_bio_metric_usecase.dart';
import 'package:domain/usecase/user/check_bio_metric_support_use_case.dart';
import 'package:domain/usecase/user/check_version_update_usecase.dart';
import 'package:domain/usecase/user/generate_key_pair_usecase.dart';
import 'package:domain/usecase/user/get_cipher_usecase.dart';
import 'package:domain/usecase/user/get_current_user_usecase.dart';
import 'package:domain/usecase/user/iphone_login_usecase.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BasePageViewModel {
  final RegisterCustomerUseCase _registerCustomerUseCase;
  final RegisterAccountUseCase _registerAccountUseCase;
  final AccountUploadUseCase _accountUploadUseCase;
  final LoginUseCase _loginUseCase;
  final CheckKYCStatusUseCase _kycStatusUseCase;
  final GetCipherUseCase _getCipherUseCase;
  final AndroidLoginUseCase _androidLoginUseCase;
  final IphoneLoginUseCase _iphoneLoginUseCase;
  final CheckBioMetricSupportUseCase _checkBioMetricSupportUseCase;
  final AuthenticateBioMetricUseCase _authenticateBioMetricUseCase;
  final SendOtpTokenEmailOtpUseCase _sendOtpTokenEmailOtpUseCase;
  final SendOtpTokeDeviceChangeOtpUseCase _sendOtpTokeDeviceChangeOtpUseCase;
  final CheckVersionUpdateUseCase _checkVersionUpdateUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final GenerateKeyPairUseCase _generateKeyPairUseCase;
  final InfobipMessagePluginUseCase _infobipMessagePluginUseCase;

  final TextEditingController emailController = TextEditingController(/*text: 'Wahaj98@g.com'*/);
  final TextEditingController passwordController = TextEditingController(/*text: 'Wahaj@123'*/);
  final ScrollController scrollController = ScrollController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "login_email");
  final GlobalKey<AppTextFieldState> passwordKey = GlobalKey(debugLabel: "login_password");

  PublishSubject<LoginUseCaseParams> _loginRequest = PublishSubject();

  PublishSubject<Resource<User>> _loginResponse = PublishSubject();

  Stream<Resource<User>> get loginStream => _loginResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///kyc status request
  PublishSubject<CheckKYCStatusUseCaseParams> _kycStatusRequest = PublishSubject();

  ///kyc status response
  PublishSubject<Resource<CheckKycResponse>> _kycStatusResponse = PublishSubject();

  ///kyc status response stream
  Stream<Resource<CheckKycResponse>> get kycStatusStream => _kycStatusResponse.stream;

  ///get cipher usecase
  PublishSubject<GetCipherUseCaseParams> _getCipherRequest = PublishSubject();

  PublishSubject<Resource<GetCipherResponse>> _getCipherResponse = PublishSubject();

  Stream<Resource<GetCipherResponse>> get getCipherStream => _getCipherResponse.stream;

  BehaviorSubject<bool> _fingerPrintShowRequest = BehaviorSubject.seeded(false);

  Stream<bool> get fingerPrintShowStream => _fingerPrintShowRequest.stream;

  ///android login
  PublishSubject<AndroidLoginUseCaseParams> _androidLoginRequest = PublishSubject();

  PublishSubject<Resource<AndroidLoginResponse>> _androidLoginResponse = PublishSubject();

  Stream<Resource<AndroidLoginResponse>> get androidLoginStream => _androidLoginResponse.stream;

  ///iphone login
  PublishSubject<IphoneLoginUseCaseParams> _iphoneLoginRequest = PublishSubject();

  PublishSubject<Resource<User>> _iphoneLoginResponse = PublishSubject();

  Stream<Resource<User>> get iphoneLoginStream => _iphoneLoginResponse.stream;

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

  /// send otp email request
  PublishSubject<SendOtpTokenEmailOtpUseCaseParams> _sendOtpTokenEmailRequest = PublishSubject();

  /// send otp mobile request
  PublishSubject<SendOtpTokeDeviceChangeOtpUseCaseParams> _sendOtpTokenMobileRequest = PublishSubject();

  /// send otp mobile response
  PublishSubject<Resource<bool>> _sendOtpTokenMobileResponse = PublishSubject();

  /// send otp mobile response stream
  Stream<Resource<bool>> get sendOtpTokenMobileStream => _sendOtpTokenMobileResponse.stream;

  String mobileNumber = '';
  String mobileCode = '';
  String applicationId = '';

  ///version update
  PublishSubject<CheckVersionUpdateUseCaseParams> _checkVersionUpdateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _checkVersionUpdateResponse = PublishSubject();

  Stream<Resource<bool>> get checkVersionUpdateStream => _checkVersionUpdateResponse.stream;

  /// current user request holder subject
  final PublishSubject<GetCurrentUserUseCaseParams> _currentUserRequestSubject = PublishSubject();

  /// current user response holder subject
  final PublishSubject<Resource<User>> _currentUserResponseSubject = PublishSubject();

  /// current user response holder stream
  Stream<Resource<User>> get currentUser => _currentUserResponseSubject.stream;

  /// generate key pair request
  PublishSubject<GenerateKeyPairUseCaseParams> _generateKeyPairRequest = PublishSubject();

  /// generate key pair response
  PublishSubject<Resource<GenerateKeyPairResponse>> _generateKeyPairResponse = PublishSubject();

  /// generate key pair response stream
  Stream<Resource<GenerateKeyPairResponse>> get generateKeyPairStream => _generateKeyPairResponse.stream;

  ///register infopib message service
  PublishSubject<InfobipMessagePluginUseCaseParams> _initInfobipMessageRequestSubject = PublishSubject();

  List<LanguageEnum> language = [
    LanguageEnum.ENGLISH,
    LanguageEnum.ARABIC,
  ];

  /// selected language
  BehaviorSubject<LanguageEnum> _selectedLanguage = BehaviorSubject.seeded(LanguageEnum.ENGLISH);

  /// selected language stream
  Stream<LanguageEnum> get selectedLanguageStream => _selectedLanguage.stream;

  bool isBiometricDialogShown = false;

  ///*-------------------- [Register Customer] ---------------------

  PublishSubject<RegisterCustomerUsecaseParams> _cliqRegisterCustomerRequest = PublishSubject();
  PublishSubject<Resource<bool>> _cliqRegisterCustomerResponse = PublishSubject();

  Stream<Resource<bool>> get cliqRegisterCustomerStream => _cliqRegisterCustomerResponse.stream;

  void cliqRegisterCustomer() => _cliqRegisterCustomerRequest.safeAdd(RegisterCustomerUsecaseParams());

  ///*---------------------- [Register Account] -------------------

  PublishSubject<RegisterAccountUsecaseParams> _registerAccountRequest = PublishSubject();
  PublishSubject<Resource<bool>> _registerAccountResponse = PublishSubject();

  Stream<Resource<bool>> get registerAccountStream => _registerAccountResponse.stream;

  void registerAccount() => _registerAccountRequest.safeAdd(RegisterAccountUsecaseParams());

  ///*---------------------- [Account Upload] -------------------

  PublishSubject<AccountUploadUseCaseParams> _accountUploadrequest = PublishSubject();
  PublishSubject<Resource<bool>> _accountUploadResponse = PublishSubject();

  Stream<Resource<bool>> get accountUploadStream => _accountUploadResponse.stream;

  void accountUpload() => _accountUploadrequest.safeAdd(AccountUploadUseCaseParams());

  LoginViewModel(
    this._loginUseCase,
    this._kycStatusUseCase,
    this._getCipherUseCase,
    this._androidLoginUseCase,
    this._iphoneLoginUseCase,
    this._checkBioMetricSupportUseCase,
    this._authenticateBioMetricUseCase,
    this._sendOtpTokenEmailOtpUseCase,
    this._sendOtpTokeDeviceChangeOtpUseCase,
    this._checkVersionUpdateUseCase,
    this._getCurrentUserUseCase,
    this._generateKeyPairUseCase,
    this._infobipMessagePluginUseCase,
    this._registerCustomerUseCase,
    this._registerAccountUseCase,
    this._accountUploadUseCase,
  ) {
    _loginRequest.listen((value) {
      RequestManager(value, createCall: () => _loginUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _loginResponse.safeAdd(event);
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

    _getCipherRequest.listen((value) {
      RequestManager(value, createCall: () => _getCipherUseCase.execute(params: value))
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

    _iphoneLoginRequest.listen((value) {
      RequestManager(value, createCall: () => _iphoneLoginUseCase.execute(params: value))
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

    _sendOtpTokenEmailRequest.listen((value) {
      RequestManager(value, createCall: () => _sendOtpTokenEmailOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          sendOtpTokenMobile();
        }
      });
    });

    _sendOtpTokenMobileRequest.listen((value) {
      RequestManager(value, createCall: () => _sendOtpTokeDeviceChangeOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _sendOtpTokenMobileResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _checkVersionUpdateRequest.listen((value) {
      RequestManager(value, createCall: () => _checkVersionUpdateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        //updateLoader();
        _checkVersionUpdateResponse.safeAdd(event);
      });
    });

    _currentUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _getCurrentUserUseCase.execute(params: value);
      }).asFlow().listen((event) async {
        _currentUserResponseSubject.add(event);
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

    _initInfobipMessageRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _infobipMessagePluginUseCase.execute(params: value);
      }).asFlow().listen((event) {
        if (event.status == Status.SUCCESS) {
          AppConstantsUtils.isInfobipRegistered = true;
        }
      });
    });
    {
      _cliqRegisterCustomerRequest.listen((value) {
        RequestManager(value, createCall: () => _registerCustomerUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            //updateLoader();
            _cliqRegisterCustomerResponse.safeAdd(event);
            if (event.status == Status.SUCCESS) {
              registerAccount();
            } else if (event.status == Status.ERROR) {
              registerAccount();
            }
          },
        );
      });
    }
    {
      _registerAccountRequest.listen((value) {
        RequestManager(value, createCall: () => _registerAccountUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            //updateLoader();
            _registerAccountResponse.safeAdd(event);
            if (event.status == Status.SUCCESS) {
              accountUpload();
            } else if (event.status == Status.ERROR) {
              accountUpload();
            }
          },
        );
      });
    }
    {
      _accountUploadrequest.listen((value) {
        RequestManager(value, createCall: () => _accountUploadUseCase.execute(params: value)).asFlow().listen(
          (event) {
            //updateLoader();
            _accountUploadResponse.safeAdd(event);
          },
        );
      });
    }

    //getCipher();
  }

  void checkBiometric() {
    _checkBioMetricRequest.add(
      CheckBioMetricSupportUseCaseParams(),
    );
  }

  /// Authenticate before set the biometric
  void authenticateBioMetric({String title: "", String localisedReason: ""}) {
    _authenticateBioMetricRequest.safeAdd(
      AuthenticateBioMetricUseCaseParams(title: title, localisedReason: localisedReason),
    );
  }

  void fingerPrintShow(bool value) {
    _fingerPrintShowRequest.safeAdd(value);
  }

  void validateEmail() {
    _loginRequest.safeAdd(LoginUseCaseParams(
        email: emailController.text,
        password: passwordController.text,
        languageEnum: _selectedLanguage.value.toString()));
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

  void sendOtpTokenEmail() {
    _sendOtpTokenEmailRequest.safeAdd(SendOtpTokenEmailOtpUseCaseParams());
  }

  void sendOtpTokenMobile() {
    _sendOtpTokenMobileRequest.safeAdd(SendOtpTokeDeviceChangeOtpUseCaseParams());
  }

  void getCipher() {
    _getCipherRequest.safeAdd(GetCipherUseCaseParams());
  }

  void checkVersionUpdate({String? clear}) {
    _checkVersionUpdateRequest.safeAdd(CheckVersionUpdateUseCaseParams(clear: clear!));
  }

  ///get current user
  void getCurrentUser() {
    _currentUserRequestSubject.add(GetCurrentUserUseCaseParams());
  }

  void generateKeyPair() {
    _generateKeyPairRequest.safeAdd(GenerateKeyPairUseCaseParams());
  }

  void initInfobipMessagePlugin() async {
    if (!AppConstantsUtils.isInfobipRegistered) {
      _initInfobipMessageRequestSubject.safeAdd(InfobipMessagePluginUseCaseParams());
    }
  }

  ///setting selected language to secure storage
  void setLanguage(LanguageEnum language, BuildContext context) {
    _selectedLanguage.safeAdd(language);
    ProviderScope.containerOf(context).read(appViewModel).toggleLocale(language);
    setLanguageToStorage(language);
  }

  getLanguageFromStorage(BuildContext context) async {
    LanguageEnum? selectedLanguage = await SecureStorageHelper.instance.getUserSelectedLanguageFromStorage();
    if (selectedLanguage != null) {
      _selectedLanguage.add(selectedLanguage);
      ProviderScope.containerOf(context).read(appViewModel).toggleLocale(selectedLanguage);
    }
  }

  setLanguageToStorage(LanguageEnum languageEnum) async {
    await SecureStorageHelper.instance.saveUserSelectedLanguageToStorage(language: languageEnum.toString());
  }

  ///--------------------Efawateercom/Cliq Registration API-----------------///

  // isolates
  late ReceivePort receivePort;
  Isolate? isolate;

  void registerCliqEfawateer() async {
    debugPrint("Entered in registration------->");
    if (isolate != null) {
      debugPrint("Isolate not null");
      return;
    }
    try {
      receivePort = ReceivePort();
      isolate = await Isolate.spawn(_getTokenCallBack, receivePort.sendPort);
      receivePort.listen(_handleMessage, onDone: () {});
    } on Exception catch (e) {
      debugPrint("isolate catch section-------> " + e.toString());
    }
  }

  static void _getTokenCallBack(SendPort sendPort) async {
    sendPort.send('Send');
  }

  void _handleMessage(message) {
    _cliqRegisterCustomerRequest.safeAdd(RegisterCustomerUsecaseParams());
  }

  ///--------------------Efawateercom/Cliq Registration API-----------------///

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
