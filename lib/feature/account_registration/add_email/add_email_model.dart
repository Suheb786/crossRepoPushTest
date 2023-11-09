import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:domain/usecase/user/check_username_usecase.dart';
import 'package:domain/usecase/user/create_password_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddEmailViewModel extends BasePageViewModel {
  final CheckUserNameUseCase _checkUserNameUseCase;
  final CreatePasswordUseCase _createPasswordUseCase;

  ///controllers and keys

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "email");

  final TextEditingController createPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<AppTextFieldState> passwordKey = GlobalKey(debugLabel: "createPassword");
  final GlobalKey<AppTextFieldState> confirmPasswordKey = GlobalKey(debugLabel: "confirmPassword");

  ///create password request subject holder
  PublishSubject<CreatePasswordUseCaseParams> _createPasswordRequest = PublishSubject();

  /// create password response subject holder
  PublishSubject<Resource<bool>> _createPasswordResponse = PublishSubject();

  Stream<Resource<bool>> get createPasswordStream => _createPasswordResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  /// EMAIL value listener
  final PublishSubject<String> _emailInputStream = PublishSubject();

  /// Email availability
  PublishSubject<CheckUserNameUseCaseParams> _checkUserNameRequest = PublishSubject();

  PublishSubject<Resource<CheckUsername>> _checkUserNameResponse = PublishSubject();

  Stream<Resource<CheckUsername>> get checkUserNameStream => _checkUserNameResponse.stream;

  /// Email availability
  bool isEmailAvailable = false;
  int isEmailExist = 7;

  CountryData countryData = CountryData();

  AddEmailViewModel(this._checkUserNameUseCase, this._createPasswordUseCase) {
    _emailInputStream.stream.debounceTime(Duration(milliseconds: 800)).distinct().listen((email) {
      if (Validator.validateEmail(email)) {
        checkEmailAvailability();
      } else {
        isEmailAvailable = false;
      }
    });

    _checkUserNameRequest.listen((value) {
      RequestManager(value, createCall: () => _checkUserNameUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          isEmailAvailable = event.data?.isAvailable ?? false;
          isEmailExist = 0;
        } else if (event.status == Status.ERROR) {
          isEmailAvailable = false;
        }
        _checkUserNameResponse.safeAdd(event);
        validate();
      });
    });

    _createPasswordRequest.listen((value) {
      RequestManager(value, createCall: () => _createPasswordUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _createPasswordResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          getError(event);
        }
      });
    });

    //getAllowedCountryCode();
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  /// Check Request for email is registered already or not
  void checkEmailAvailability() {
    _checkUserNameRequest.safeAdd(CheckUserNameUseCaseParams(email: emailController.text));
  }

  /// Validate email is registered with system or not
  void validateEmail() {
    _emailInputStream.safeAdd(emailController.text);
  }

  void validate() {
    if (isEmailAvailable &&
        createPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  ///password Validation
  bool hasUpperCase = false;
  bool hasSymbol = false;
  bool minimumEightCharacters = false;
  bool containsDigit = false;

  void validatePassword() {
    minimumEightCharacters = createPasswordController.text.length > 7;
    hasUpperCase = Validator.hasUpperCase(createPasswordController.text);
    hasSymbol = Validator.hasSymbol(createPasswordController.text);
    containsDigit = Validator.containsDigit(createPasswordController.text);
    notifyListeners();
  }

  void createPassword() {
    _createPasswordRequest.safeAdd(CreatePasswordUseCaseParams(
      createPassword: createPasswordController.text,
      confirmPassword: confirmPasswordController.text,
      minimumEightCharacters: minimumEightCharacters,
      hasUpperCase: hasUpperCase,
      hasSymbol: hasSymbol,
      containsDigit: containsDigit,
      isEmailExist: isEmailExist,
      emailAddress: emailController.text.trim(),
    ));
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _emailInputStream.close();
    _checkUserNameRequest.close();
    _checkUserNameResponse.close();
    _createPasswordResponse.close();
    _createPasswordRequest.close();
    super.dispose();
  }
}
