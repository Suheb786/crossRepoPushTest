import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/usecase/country/fetch_country_by_code_usecase.dart';
import 'package:domain/usecase/country/get_allowed_code_country_list_usecase.dart';
import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_new_mobile_number_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DcEnterNewMobileNumberPageViewModel extends BasePageViewModel {
  final FetchCountryByCodeUseCase _fetchCountryByCodeUseCase;
  final GetAllowedCodeCountryListUseCase _allowedCodeCountryListUseCase;
  final DcEnterNewMobileNumberUseCase _dcEnterNewMobileNumberUseCase;

  /// enter mobile usecase
  PublishSubject<DcEnterNewMobileNumberUseCaseParams> _enterMobileRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _enterMobileResponse = PublishSubject();

  Stream<Resource<bool>> get enterMobileStream => _enterMobileResponse.stream;

  ///controllers and keys
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey =
      GlobalKey(debugLabel: "mobileNumber");

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "email");

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///COUNTRY
  PublishSubject<FetchCountryByCodeUseCaseParams> _fetchCountryRequest =
      PublishSubject();

  BehaviorSubject<Resource<Country>> _fetchCountryResponse = BehaviorSubject();

  Stream<Resource<Country>> get countryByCode => _fetchCountryResponse.stream;

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
      BehaviorSubject.seeded(CountryData(isoCode3: 'JOR', phoneCode: '962'));

  ///get allowed code country response stream
  Stream<CountryData> get getSelectedCountryStream =>
      _selectedCountryResponse.stream;

  bool isMobileValidated = false;

  /// Phone value listener
  final PublishSubject<String> _phoneInputStream = PublishSubject();

  DcEnterNewMobileNumberPageViewModel(
      this._fetchCountryByCodeUseCase,
      this._allowedCodeCountryListUseCase,
      this._dcEnterNewMobileNumberUseCase) {
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

    _enterMobileRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _dcEnterNewMobileNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _enterMobileResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.SUCCESS) {
          isMobileValidated = event.data!;
          validate();
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

    _phoneInputStream.stream
        .debounceTime(Duration(milliseconds: 800))
        .distinct()
        .listen((phone) {
      if (phone.length > 7) {
        validateMobile();
      } else {
        isMobileValidated = false;
        validate();
      }
    });

    //getAllowedCountryCode();
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

  /// get allowed country code
  void getAllowedCountryCode() {
    _getAllowedCountryRequest.safeAdd(GetAllowedCodeCountryListUseCaseParams());
  }

  void setSelectedCountry(CountryData data) {
    _selectedCountryResponse.safeAdd(data);
  }

  void checkMobileNumber() {
    _phoneInputStream.safeAdd(mobileNumberController.text);
  }

  void validateMobile() {
    _enterMobileRequest.safeAdd(DcEnterNewMobileNumberUseCaseParams(
        mobileNumber: mobileNumberController.text));
  }

  void validate() {
    if (isMobileValidated) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _fetchCountryRequest.close();
    _fetchCountryResponse.close();
    _getAllowedCountryRequest.close();
    _getAllowedCountryResponse.close();
    _selectedCountryResponse.close();
    super.dispose();
  }
}
