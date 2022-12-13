import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/usecase/country/get_allowed_code_country_list_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_mobile_no_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import 'edit_cliq_id_mobile_no_page.dart';

class EditCliqIDMobileNoPageViewModel extends BasePageViewModel {
  final EditCliqIDMobileNoPageArguments arguments;
  final EditCliqMobileNoValidationUseCase _editCliqMobileNoValidationUseCase;
  final EditCliqOtpUseCase _editCliqOtpUseCase;
  final GetAllowedCodeCountryListUseCase _allowedCodeCountryListUseCase;

  ///controllers and keys
  final TextEditingController mobileNoController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey = GlobalKey(debugLabel: "mobileNumber");

  EditCliqIDMobileNoPageViewModel(this._editCliqMobileNoValidationUseCase, this._editCliqOtpUseCase,
      this._allowedCodeCountryListUseCase, this.arguments) {
    mobileNoController.text = arguments.aliasName;

    /// validation request
    _editMobileNoValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _editCliqMobileNoValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _editMobileNoValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          getError(event);
        }
      });
    });

    ///api calling for otp
    _editCliqOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _editCliqOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _editCliqOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
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

  void setSelectedCountry(CountryData data) {
    _selectedCountryResponse.safeAdd(data);
  }

  /// get allowed country code
  void getAllowedCountryCode() {
    _getAllowedCountryRequest.safeAdd(GetAllowedCodeCountryListUseCaseParams());
  }

  /// error indicator in ui

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_MOBILE:
        mobileNumberKey.currentState!.isValid = false;
        break;

      default:
        break;
    }
  }

  void termAndConditionSelected(bool value) {
    _isSelectedRequest.safeAdd(value);
    _showButtonSubject.safeAdd(value);
  }

  void validate() {
    _editMobileNoValidationRequest.safeAdd(EditCliqMobileNoValidationUseCaseParams(
        isSelected: _isSelectedRequest.value, mobileNo: mobileNoController.text));
  }

  void makeOtpRequest({
    required String aliasId,
    required String aliasValue,
    required bool isAlias,
  }) {
    _editCliqOtpRequest.safeAdd(EditCliqOtpUseCaseParams(
      aliasId: aliasId,
      aliasValue: aliasValue,
      isAlias: isAlias,
    ));
  }

  void showBtn() {
    if (mobileNoController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _selectedCountryResponse.close();
    _editCliqOtpRequest.close();
    _editCliqOtpResponse.close();
    _getAllowedCountryRequest.close();
    _getAllowedCountryResponse.close();
    _isSelectedRequest.close();
    _showButtonSubject.close();
    _editMobileNoValidationRequest.close();
    _editMobileNoValidationResponse.close();
    super.dispose();
  }

  ///-------------------------------------variable---------------------------------------
  ///
  PublishSubject<EditCliqOtpUseCaseParams> _editCliqOtpRequest = PublishSubject();

  PublishSubject<Resource<EditCliqOtp>> _editCliqOtpResponse = PublishSubject();

  Stream<Resource<EditCliqOtp>> get editCliqIdOtpStream => _editCliqOtpResponse.stream;

  CountryData countryData = CountryData();

  ///selected country response holder
  BehaviorSubject<CountryData> _selectedCountryResponse = BehaviorSubject.seeded(CountryData());

  ///get allowed code country response stream
  Stream<CountryData> get getSelectedCountryStream => _selectedCountryResponse.stream;

  ///get allowed code country request holder
  PublishSubject<GetAllowedCodeCountryListUseCaseParams> _getAllowedCountryRequest = PublishSubject();

  ///get allowed code country response holder
  PublishSubject<Resource<AllowedCountryListResponse>> _getAllowedCountryResponse = PublishSubject();

  ///get allowed code country response stream
  Stream<Resource<AllowedCountryListResponse>> get getAllowedCountryStream =>
      _getAllowedCountryResponse.stream;

  BehaviorSubject<bool> _isSelectedRequest = BehaviorSubject();

  Stream<bool> get isSelectedStream => _isSelectedRequest.stream;

  ///-------validation request and response

  PublishSubject<EditCliqMobileNoValidationUseCaseParams> _editMobileNoValidationRequest = PublishSubject();

  PublishSubject<Resource<bool>> _editMobileNoValidationResponse = PublishSubject();

  Stream<Resource<bool>> get editMobileNoValidationResponseStream => _editMobileNoValidationResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;
}
