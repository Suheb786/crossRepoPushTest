import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:domain/usecase/account/send_mobile_otp_usecase.dart';
import 'package:domain/usecase/country/fetch_country_by_code_usecase.dart';
import 'package:domain/usecase/country/get_allowed_code_country_list_usecase.dart';
import 'package:domain/usecase/user/check_user_name_mobile_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
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
  final CheckUserNameMobileUseCase _checkUserNameMobileUseCase;
  final GetAllowedCodeCountryListUseCase _allowedCodeCountryListUseCase;
  final SendMobileOTPUsecase _sendMobileOTPUsecase;

  ///controllers and keys
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey = GlobalKey(debugLabel: "mobileNumber");

  PublishSubject<RegisterNumberUseCaseParams> _registerNumberRequest = PublishSubject();

  PublishSubject<Resource<bool>> _registerNumberResponse = PublishSubject();

  Stream<Resource<bool>> get registerNumberStream => _registerNumberResponse.stream;

  PublishSubject<SendMobileOTPUsecaseParams> _sendMobileOTPRequest = PublishSubject();

  PublishSubject<Resource<bool>> _sendMobileOTPResponse = PublishSubject();

  Stream<Resource<bool>> get sendMobileOTPStream => _sendMobileOTPResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///COUNTRY
  PublishSubject<FetchCountryByCodeUseCaseParams> _fetchCountryRequest = PublishSubject();

  BehaviorSubject<Resource<Country>> _fetchCountryResponse = BehaviorSubject();

  Stream<Resource<Country>> get countryByCode => _fetchCountryResponse.stream;

  PublishSubject<Resource<CheckUsername>> _checkUserNameResponse = PublishSubject();

  Stream<Resource<CheckUsername>> get checkUserNameStream => _checkUserNameResponse.stream;

  /// Phone value listener
  final PublishSubject<String> _phoneInputStream = PublishSubject();

  /// Email availability
  PublishSubject<CheckUserNameMobileUseCaseParams> _checkUserMobileRequest = PublishSubject();

  PublishSubject<Resource<CheckUsername>> _checkUserMobileResponse = PublishSubject();

  Stream<Resource<CheckUsername>> get checkUserMobileStream => _checkUserMobileResponse.stream;

  bool isNumberAvailable = false;
  Country selectedCountry = Country();
  int isMobileNoExist = 7;

  CountryData countryData = CountryData();

  ///get allowed code country request holder
  PublishSubject<GetAllowedCodeCountryListUseCaseParams> _getAllowedCountryRequest = PublishSubject();

  ///get allowed code country response holder
  PublishSubject<Resource<AllowedCountryListResponse>> _getAllowedCountryResponse = PublishSubject();

  ///get allowed code country response stream
  Stream<Resource<AllowedCountryListResponse>> get getAllowedCountryStream =>
      _getAllowedCountryResponse.stream;

  ///selected country response holder
  BehaviorSubject<CountryData> _selectedCountryResponse =
      BehaviorSubject.seeded(CountryData(isoCode3: 'JOR', phoneCode: '962'));

  ///get allowed code country response stream
  Stream<CountryData> get getSelectedCountryStream => _selectedCountryResponse.stream;

  AddNumberViewModel(this._registerNumberUseCase, this._fetchCountryByCodeUseCase,
      this._checkUserNameMobileUseCase, this._allowedCodeCountryListUseCase, this._sendMobileOTPUsecase) {
    _registerNumberRequest.listen((value) {
      RequestManager(value, createCall: () => _registerNumberUseCase.execute(params: value))
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
      RequestManager(value, createCall: () => _fetchCountryByCodeUseCase.execute(params: value))
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
      RequestManager(value, createCall: () => _allowedCodeCountryListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAllowedCountryResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.SUCCESS) {
          countryData = event.data!.contentData!.countryData!.firstWhere(
              (element) => element.isoCode3 == 'JOR',
              orElse: () => event.data!.contentData!.countryData!.first);
          setSelectedCountry(countryData);
        } else if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
          showErrorState();
        }
      });
    });

    _phoneInputStream.stream.debounceTime(Duration(milliseconds: 800)).distinct().listen((phone) {
      if (phone.length > 7) {
        checkPhoneAvailability();
      } else {
        isNumberAvailable = false;
        validate();
      }
    });

    _checkUserMobileRequest.listen((value) {
      RequestManager(value, createCall: () => _checkUserNameMobileUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          isNumberAvailable = event.data?.isAvailable ?? false;
          isMobileNoExist = 0;
        }
        _checkUserMobileResponse.safeAdd(event);
        validate();
      });
    });

    _sendMobileOTPRequest.listen((value) {
      RequestManager(value, createCall: () => _sendMobileOTPUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        _sendMobileOTPResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.SUCCESS) {
        } else if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
          showErrorState();
        }
      });
    });

    // getAllowedCountryCode();
  }

  void fetchCountryByCode(BuildContext context, String code) {
    _fetchCountryRequest.safeAdd(FetchCountryByCodeUseCaseParams(context: context, countryCode: code));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_MOBILE:
        mobileNumberKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void validateNumber() {
    _registerNumberRequest.safeAdd(RegisterNumberUseCaseParams(
        isMobileNoExist: isMobileNoExist,
        countryCode: countryData.isoCode,
        mobileNumber: mobileNumberController.text));
  }

  /// Check Request for email is registered already or not
  void checkPhoneAvailability() {
    _checkUserMobileRequest.safeAdd(CheckUserNameMobileUseCaseParams(
        mobileNumber: mobileNumberController.text, countryCode: countryData.isoCode3 ?? ''));
  }

  /// Validate mobile is registered with system or not
  void validateMobile() {
    _phoneInputStream.safeAdd(mobileNumberController.text);
  }

  void validate() {
    print('isNumberAvailable---->$isNumberAvailable');
    if (isNumberAvailable) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void sendMobileOtp({required String MobileNumber, required String MobileCode}) {
    _sendMobileOTPRequest.safeAdd(
        SendMobileOTPUsecaseParams(GetToken: true, MobileNumber: MobileNumber, MobileCode: MobileCode));
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
