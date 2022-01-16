import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:domain/usecase/country/fetch_country_by_code_usecase.dart';
import 'package:domain/usecase/country/get_allowed_code_country_list_usecase.dart';
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
  final GetAllowedCodeCountryListUseCase _allowedCodeCountryListUseCase;

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

  PublishSubject<Resource<CheckUsername>> _checkUserNameResponse =
      PublishSubject();

  Stream<Resource<CheckUsername>> get checkUserNameStream =>
      _checkUserNameResponse.stream;

  /// Phone value listener
  final PublishSubject<String> _phoneInputStream = PublishSubject();

  /// Email availability
  PublishSubject<CheckUserNameMobileUseCaseParams> _checkUserMobileRequest =
      PublishSubject();

  PublishSubject<Resource<CheckUsername>> _checkUserMobileResponse =
      PublishSubject();

  Stream<Resource<CheckUsername>> get checkUserMobileStream =>
      _checkUserMobileResponse.stream;

  bool isEmailAvailable = false;
  bool isNumberAvailable = false;
  Country selectedCountry = Country();

  CountryData countryData = CountryData();

  ///get allowed code country request holder
  PublishSubject<GetAllowedCodeCountryListUseCaseParams>
      _getAllowedCountryRequest = PublishSubject();

  ///get allowed code country response holder
  PublishSubject<Resource<AllowedCountryListResponse>>
      _getAllowedCountryResponse = PublishSubject();

  ///get allowed code country response stream
  Stream<Resource<AllowedCountryListResponse>> get getAllowedCountryStream =>
      _getAllowedCountryResponse.stream;

  ///selected country response holder
  BehaviorSubject<CountryData> _selectedCountryResponse =
      BehaviorSubject.seeded(CountryData());

  ///get allowed code country response stream
  Stream<CountryData> get getSelectedCountryStream =>
      _selectedCountryResponse.stream;

  AddNumberViewModel(
      this._registerNumberUseCase,
      this._fetchCountryByCodeUseCase,
      this._checkUserNameUseCase,
      this._checkUserNameMobileUseCase,
      this._allowedCodeCountryListUseCase) {
    _registerNumberRequest.listen((value) {
      RequestManager(value,
              createCall: () => _registerNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _registerNumberResponse.safeAdd(event);
        updateLoader();
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
        updateLoader();
        if (event.status == Status.SUCCESS) {
          selectedCountry = event.data!;
        }
      });
    });

    _getAllowedCountryRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _allowedCodeCountryListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAllowedCountryResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.SUCCESS) {
          countryData = event.data!.contentData!.countryData!.first;
          setSelectedCountry(countryData);
        } else if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
          showErrorState();
        }
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
        updateLoader();
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
      if (phone.length > 7) {
        checkPhoneAvailability();
      }
    });

    _checkUserMobileRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _checkUserNameMobileUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          isNumberAvailable = event.data?.isAvailable ?? false;
        }
        _checkUserMobileResponse.safeAdd(event);
        validate();
      });
    });
    getAllowedCountryCode();
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
      default:
        break;
    }
  }

  void validateNumber() {
    _registerNumberRequest.safeAdd(RegisterNumberUseCaseParams(
        emailAddress: emailController.text,
        countryCode: countryData.isoCode,
        mobileNumber: mobileNumberController.text));
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
        mobileNumber: mobileNumberController.text,
        countryCode: countryData.isoCode3 ?? ''));
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

  /// get allowed country code
  void getAllowedCountryCode() {
    _getAllowedCountryRequest.safeAdd(GetAllowedCodeCountryListUseCaseParams());
  }

  void setSelectedCountry(CountryData data) {
    _selectedCountryResponse.safeAdd(data);
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
    _getAllowedCountryRequest.close();
    _getAllowedCountryResponse.close();
    _selectedCountryResponse.close();
    super.dispose();
  }
}
