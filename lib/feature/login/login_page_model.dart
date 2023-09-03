import 'dart:async';

import 'package:domain/constants/error_types.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/device_change/send_otp_token_device_change_usecase.dart';
import 'package:domain/usecase/kyc/check_kyc_status_usecase.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BasePageViewModel {
  final LoginUseCase _loginUseCase;
  final CheckKYCStatusUseCase _kycStatusUseCase;
  final SendOtpTokeDeviceChangeOtpUseCase _sendOtpTokeDeviceChangeOtpUseCase;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "login_email");
  final GlobalKey<AppTextFieldState> passwordKey = GlobalKey(debugLabel: "login_password");

  ///---------------------Login Request Response ---------------------///

  String mobileNumber = '';
  String mobileCode = '';
  String applicationId = '';

  PublishSubject<LoginUseCaseParams> _loginRequest = PublishSubject();

  PublishSubject<Resource<User>> _loginResponse = PublishSubject();

  Stream<Resource<User>> get loginStream => _loginResponse.stream;

  void validateEmail({required BuildContext context}) {
    _loginRequest.safeAdd(LoginUseCaseParams(
        email: emailController.text,
        password: passwordController.text,
        languageEnum: ProviderScope.containerOf(context).read(appViewModel).selectedLanguageEnum.toString()));
  }

  ///---------------------Login Request Response ---------------------///

  ///--------------------- Button Visibility ---------------------///
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void validate() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(false);
    } else {
      _showButtonSubject.safeAdd(true);
    }
  }

  ///--------------------- Button Visibility ---------------------///

  ///--------------------- KYC Status ---------------------///

  PublishSubject<CheckKYCStatusUseCaseParams> _kycStatusRequest = PublishSubject();

  PublishSubject<Resource<CheckKycResponse>> _kycStatusResponse = PublishSubject();

  Stream<Resource<CheckKycResponse>> get kycStatusStream => _kycStatusResponse.stream;

  void checkKycStatus() {
    _kycStatusRequest.safeAdd(CheckKYCStatusUseCaseParams());
  }

  ///--------------------- KYC Status ---------------------///

  ///--------------------- Send otp token mobile -----------------///

  PublishSubject<SendOtpTokeDeviceChangeOtpUseCaseParams> _sendOtpTokenMobileRequest = PublishSubject();

  PublishSubject<Resource<bool>> _sendOtpTokenMobileResponse = PublishSubject();

  Stream<Resource<bool>> get sendOtpTokenMobileStream => _sendOtpTokenMobileResponse.stream;

  void sendOtpTokenMobile() {
    _sendOtpTokenMobileRequest.safeAdd(SendOtpTokeDeviceChangeOtpUseCaseParams());
  }

  ///--------------------- Send otp token mobile -----------------///

  LoginViewModel(this._loginUseCase, this._kycStatusUseCase, this._sendOtpTokeDeviceChangeOtpUseCase) {
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

    if (kDebugMode) {
      emailController.text = "wahaj98@g.com";
      passwordController.text = "Wahaj@123";
    }
  }

  @override
  void dispose() {
    _loginRequest.close();
    _loginResponse.close();
    _showButtonSubject.close();
    _kycStatusRequest.close();
    _kycStatusResponse.close();
    _sendOtpTokenMobileRequest.close();
    _sendOtpTokenMobileResponse.close();
    super.dispose();
  }
}
