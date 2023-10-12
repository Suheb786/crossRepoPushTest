import 'package:data/network/utils/get_error.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:domain/usecase/account/send_mobile_otp_usecase.dart';
import 'package:domain/usecase/country/get_allowed_code_country_list_usecase.dart';
import 'package:domain/usecase/user/check_user_name_mobile_usecase.dart';
import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ChangeMyNumberDialogViewModel extends BasePageViewModel {
  ///controllers and keys
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey = GlobalKey(debugLabel: "mobileNumber");

  CountryData countryData = CountryData();

  bool initialDataSet = false;
  bool isNumberAvailable = false;
  Country selectedCountry = Country();
  int isMobileNoExist = 7;

  ///selected country response holder
  BehaviorSubject<CountryData> _selectedCountryResponse = BehaviorSubject.seeded(CountryData());

  /// Phone value listener
  final PublishSubject<String> _phoneInputStream = PublishSubject();

  ///get allowed code country response stream
  Stream<CountryData> get getSelectedCountryStream => _selectedCountryResponse.stream;
  final CheckUserNameMobileUseCase _checkUserNameMobileUseCase;
  final RegisterNumberUseCase _registerNumberUseCase;
  final GetAllowedCodeCountryListUseCase _allowedCodeCountryListUseCase;
  final SendMobileOTPUsecase _sendMobileOTPUsecase;

  ChangeMyNumberDialogViewModel(
    this._checkUserNameMobileUseCase,
    this._registerNumberUseCase,
    this._allowedCodeCountryListUseCase,
    this._sendMobileOTPUsecase,
  ) {
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

      _phoneInputStream.stream.debounceTime(Duration(milliseconds: 800)).distinct().listen((phone) {
        if (phone.length > 7) {
          checkPhoneAvailability();
        } else {
          isNumberAvailable = false;
          validate();
        }
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
  }

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  PublishSubject<CheckUserNameMobileUseCaseParams> _checkUserMobileRequest = PublishSubject();

  PublishSubject<Resource<CheckUsername>> _checkUserMobileResponse = PublishSubject();

  Stream<Resource<CheckUsername>> get checkUserMobileStream => _checkUserMobileResponse.stream;

  ///-------register subject-------

  PublishSubject<RegisterNumberUseCaseParams> _registerNumberRequest = PublishSubject();

  PublishSubject<Resource<bool>> _registerNumberResponse = PublishSubject();

  Stream<Resource<bool>> get registerNumberStream => _registerNumberResponse.stream;

  ///---------send Mobile OTP---------

  PublishSubject<SendMobileOTPUsecaseParams> _sendMobileOTPRequest = PublishSubject();

  PublishSubject<Resource<bool>> _sendMobileOTPResponse = PublishSubject();

  ///get allowed code country request holder
  PublishSubject<GetAllowedCodeCountryListUseCaseParams> _getAllowedCountryRequest = PublishSubject();

  ///get allowed code country response holder
  PublishSubject<Resource<AllowedCountryListResponse>> _getAllowedCountryResponse = PublishSubject();

  ///get allowed code country response stream
  Stream<Resource<AllowedCountryListResponse>> get getAllowedCountryStream =>
      _getAllowedCountryResponse.stream;

  void validate() {
    print('isNumberAvailable---->$isNumberAvailable');
    if (isNumberAvailable) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
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

  /// Validate mobile is registered with system or not
  void validateMobile() {
    _phoneInputStream.safeAdd(mobileNumberController.text);
  }

  void checkPhoneAvailability() {
    _checkUserMobileRequest.safeAdd(CheckUserNameMobileUseCaseParams(
        mobileNumber: mobileNumberController.text, countryCode: countryData.isoCode3 ?? ''));
  }

  void sendMobileOtp({required String MobileNumber, required String MobileCode}) {
    _sendMobileOTPRequest.safeAdd(
        SendMobileOTPUsecaseParams(GetToken: true, MobileNumber: MobileNumber, MobileCode: MobileCode));
  }

  void setSelectedCountry(CountryData data) {
    _selectedCountryResponse.safeAdd(data);
  }
}
