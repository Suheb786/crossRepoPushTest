import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
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
  final GetAllowedCodeCountryListUseCase _allowedCodeCountryListUseCase;
  final DcEnterNewMobileNumberUseCase _dcEnterNewMobileNumberUseCase;

  /// enter mobile usecase
  PublishSubject<DcEnterNewMobileNumberUseCaseParams> _enterMobileRequest = PublishSubject();

  PublishSubject<Resource<bool>> _enterMobileResponse = PublishSubject();

  Stream<Resource<bool>> get enterMobileStream => _enterMobileResponse.stream;

  ///controllers and keys
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey = GlobalKey(debugLabel: "mobileNumber");

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  Country selectedCountry = Country();

  CountryData countryData = CountryData(isoCode3: 'JOR', phoneCode: '962');

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

  String mobileNumberWithCode = '';

  DcEnterNewMobileNumberPageViewModel(
      this._allowedCodeCountryListUseCase, this._dcEnterNewMobileNumberUseCase) {
    _enterMobileRequest.listen((value) {
      RequestManager(value, createCall: () => _dcEnterNewMobileNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterMobileResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
          getError(event);
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

    getAllowedCountryCode();
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

  /// get allowed country code
  void getAllowedCountryCode() {
    _getAllowedCountryRequest.safeAdd(GetAllowedCodeCountryListUseCaseParams());
  }

  void setSelectedCountry(CountryData data) {
    _selectedCountryResponse.safeAdd(data);
  }

  void validateMobile(String? tokenizedPan, CardType cardType) {
    mobileNumberWithCode = '+${countryData.phoneCode} ${mobileNumberController.text}';
    _enterMobileRequest.safeAdd(DcEnterNewMobileNumberUseCaseParams(
        mobileNumber: mobileNumberController.text,
        mobileCode: "00${_selectedCountryResponse.value.phoneCode}",
        cardType: cardType,
        tokenizedPan: tokenizedPan));
  }

  void validate() {
    if (mobileNumberController.text.isNotEmpty && mobileNumberController.text.length > 8) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _getAllowedCountryRequest.close();
    _getAllowedCountryResponse.close();
    _selectedCountryResponse.close();
    super.dispose();
  }
}
