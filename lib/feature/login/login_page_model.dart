import 'dart:async';

import 'package:domain/constants/error_types.dart';
import 'package:domain/model/user/user.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final GlobalKey<AppTextFieldState> emailKey =
      GlobalKey(debugLabel: "login_email");
  final GlobalKey<AppTextFieldState> passwordKey =
      GlobalKey(debugLabel: "login_password");

  PublishSubject<LoginUseCaseParams> _loginRequest = PublishSubject();

  PublishSubject<Resource<User>> _loginResponse = PublishSubject();

  Stream<Resource<User>> get loginStream => _loginResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  LoginViewModel(this._loginUseCase) {
    _loginRequest.listen((value) {
      RequestManager(value,
              createCall: () => _loginUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
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
  }

  void validateEmail() {
    _loginRequest.safeAdd(LoginUseCaseParams(
        email: emailController.text, password: passwordController.text));
  }

  void validate() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _loginRequest.close();
    _loginResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }
}
