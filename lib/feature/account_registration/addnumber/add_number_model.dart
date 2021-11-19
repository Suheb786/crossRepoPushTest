import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/model/user/check_username_response.dart';
import 'package:domain/usecase/country/fetch_country_by_code_usecase.dart';
import 'package:domain/usecase/user/check_user_name_mobile_usecase.dart';
import 'package:domain/usecase/user/check_username_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddNumberViewModel extends BasePageViewModel {
  final RegisterNumberUseCase _registerNumberUseCase;
  final FetchCountryByCodeUseCase _fetchCountryByCodeUseCase;
  final CheckUserNameUseCase _checkUserNameUseCase;
  final CheckUserNameMobileUseCase _checkUserNameMobileUseCase;

  ///controllers and keys
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey =
      GlobalKey(debugLabel: "mobileNumber");

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "email");

  PublishSubject<RegisterNumberUseCaseParams> _registerNumberRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _registerNumberResponse = PublishSubject();

  Stream<Resource<bool>> get registerNumberStream =>
      _registerNumberResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///COUNTRY
  PublishSubject<FetchCountryByCodeUseCaseParams> _fetchCountryRequest =
      PublishSubject();

  BehaviorSubject<Resource<Country>> _fetchCountryResponse = BehaviorSubject();

  Stream<Resource<Country>> get countryByCode => _fetchCountryResponse.stream;

  /// EMAIL value listener
  final PublishSubject<String> _emailInputStream = PublishSubject();

  /// Email availability
  PublishSubject<CheckUserNameUseCaseParams> _checkUserNameRequest =
      PublishSubject();

  PublishSubject<Resource<CheckUsernameResponse>> _checkUserNameResponse =
      PublishSubject();

  Stream<Resource<CheckUsernameResponse>> get checkUserNameStream =>
      _checkUserNameResponse.stream;

  /// Phone value listener
  final PublishSubject<String> _phoneInputStream = PublishSubject();

  /// Email availability
  PublishSubject<CheckUserNameMobileUseCaseParams> _checkUserMobileRequest =
      PublishSubject();

  PublishSubject<Resource<CheckUsernameResponse>> _checkUserMobileResponse =
      PublishSubject();

  Stream<Resource<CheckUsernameResponse>> get checkUserMobileStream =>
      _checkUserMobileResponse.stream;

  bool isEmailAvailable = false;
  bool isNumberAvailable = false;

  AddNumberViewModel(
      this._registerNumberUseCase,
      this._fetchCountryByCodeUseCase,
      this._checkUserNameUseCase,
      this._checkUserNameMobileUseCase) {
    _registerNumberRequest.listen((value) {
      RequestManager(value,
              createCall: () => _registerNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _registerNumberResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _fetchCountryRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _fetchCountryByCodeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _fetchCountryResponse.safeAdd(event);
      });
    });

    _emailInputStream.stream
        .debounceTime(Duration(milliseconds: 800))
        .distinct()
        .listen((email) {
      if (Validator.validateEmail(email)) {
        checkEmailAvailability();
      }
    });

    _checkUserNameRequest.listen((value) {
      RequestManager(value,
              createCall: () => _checkUserNameUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.SUCCESS) {
          isEmailAvailable = event.data?.isAvailable ?? false;
        }
        _checkUserNameResponse.safeAdd(event);
        validate();
      });
    });

    _phoneInputStream.stream
        .debounceTime(Duration(milliseconds: 800))
        .distinct()
        .listen((phone) {
      if (phone.length > 8) {
        checkPhoneAvailability();
      }
    });

    _checkUserMobileRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _checkUserNameMobileUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.SUCCESS) {
          isNumberAvailable = event.data?.isAvailable ?? false;
        }
        _checkUserMobileResponse.safeAdd(event);
        validate();
      });
    });
  }

  void fetchCountryByCode(BuildContext context, String code) {
    _fetchCountryRequest.safeAdd(
        FetchCountryByCodeUseCaseParams(context: context, countryCode: code));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_MOBILE:
        mobileNumberKey.currentState!.isValid = false;
        break;
    }
  }

  void validateNumber({required String dialCode}) {
    if (isEmailAvailable && isNumberAvailable) {
      _registerNumberRequest.safeAdd(RegisterNumberUseCaseParams(
          emailAddress: emailController.text,
          countryCode: dialCode,
          mobileNumber: mobileNumberController.text));
    }
  }

  /// Check Request for email is registered already or not
  void checkEmailAvailability() {
    _checkUserNameRequest
        .safeAdd(CheckUserNameUseCaseParams(email: emailController.text));
  }

  /// Validate email is registered with system or not
  void validateEmail() {
    _emailInputStream.safeAdd(emailController.text);
  }

  /// Check Request for email is registered already or not
  void checkPhoneAvailability() {
    _checkUserMobileRequest.safeAdd(CheckUserNameMobileUseCaseParams(
        mobileNumber: mobileNumberController.text, countryCode: 'JOR'));
  }

  /// Validate mobile is registered with system or not
  void validateMobile() {
    _phoneInputStream.safeAdd(mobileNumberController.text);
  }

  void validate() {
    if (isNumberAvailable && isEmailAvailable) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _registerNumberRequest.close();
    _registerNumberResponse.close();
    _showButtonSubject.close();
    _fetchCountryRequest.close();
    _fetchCountryResponse.close();
    _emailInputStream.close();
    _checkUserNameRequest.close();
    _checkUserNameResponse.close();
    _phoneInputStream.close();
    _checkUserMobileRequest.close();
    _checkUserMobileResponse.close();
    super.dispose();
  }
}
