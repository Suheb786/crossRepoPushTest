import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/model/country/state_list/state_city_data.dart';
import 'package:domain/model/country/state_list/state_list_response.dart';
import 'package:domain/model/fatca_crs/fatca_w9_data.dart';
import 'package:domain/usecase/country/get_city_list_usecase.dart';
import 'package:domain/usecase/country/get_state_list_usecase.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w9_address_details_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class FatcaUSRelevantW9AddressDetailsPageViewModel extends BasePageViewModel {
  final FatcaUSRelevantW9AddressDetailsUseCase
      _fatcaUSRelevantW9AddressDetailsUseCase;

  final GetStateListUseCase _getStateListUseCase;

  final GetCityListUseCase _getCityListUseCase;

  StateCityData selectedAddressInUS = StateCityData();

  StateCityData selectedAdditionalRequester = StateCityData();

  /// get state list request subject holder
  PublishSubject<GetStateListUseParams> _getStateListRequest = PublishSubject();

  /// get state list response subject holder
  BehaviorSubject<Resource<StateListResponse>> _getStateListResponse =
      BehaviorSubject();

  /// get state list response stream
  Stream<Resource<StateListResponse>> get getStateListResponseStream =>
      _getStateListResponse.stream;

  /// get city list request subject holder
  PublishSubject<GetCityListUseParams> _getCityListRequest = PublishSubject();

  /// get city list response subject holder
  PublishSubject<Resource<CityListResponse>> _getCityListResponse =
      PublishSubject();

  /// get city list response stream
  Stream<Resource<CityListResponse>> get getCityListResponseStream =>
      _getCityListResponse.stream;

  ///controllers and keys
  final TextEditingController addressController = TextEditingController();
  final GlobalKey<AppTextFieldState> addressKey =
      GlobalKey(debugLabel: "address");

  final TextEditingController stateController = TextEditingController();
  final GlobalKey<AppTextFieldState> stateKey = GlobalKey(debugLabel: "state");

  final TextEditingController cityController = TextEditingController();
  final GlobalKey<AppTextFieldState> cityKey = GlobalKey(debugLabel: "city");

  final TextEditingController postCodeController = TextEditingController();
  final GlobalKey<AppTextFieldState> postCodeKey =
      GlobalKey(debugLabel: "postCode");

  final TextEditingController accountNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> accountNumberKey =
      GlobalKey(debugLabel: "accountNumber");

  final TextEditingController exemptPayeeCodeNumberController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> exemptPayeeCodeNumberKey =
      GlobalKey(debugLabel: "exemptPayeeCode");

  final TextEditingController exemptFromFatcaReportingController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> exemptFromFatcaReportingKey =
      GlobalKey(debugLabel: "exemptFromFatcaReporting");

  ///additional requester controllers and keys
  final TextEditingController additionalRequesterNameController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> additionalRequesterNameKey =
      GlobalKey(debugLabel: "additionalRequesterName");

  final TextEditingController additionalRequesterAddressController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> additionalRequesterAddressNameKey =
      GlobalKey(debugLabel: "additionalRequesterAddress");

  final TextEditingController additionalRequesterStateController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> additionalRequesterStateKey =
      GlobalKey(debugLabel: "additionalRequesterState");

  final TextEditingController additionalRequesterCityController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> additionalRequesterCityKey =
      GlobalKey(debugLabel: "additionalRequesterCity");

  final TextEditingController additionalRequesterPostCodeController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> additionalRequesterPostCodeKey =
      GlobalKey(debugLabel: "additionalRequesterPostCode");

  ///fatca us relevant address details request subject holder
  PublishSubject<FatcaUSRelevantW9AddressDetailsUseCaseParams>
      _fatcaUSRelevantW9AddressDetailsRequest = PublishSubject();

  ///fatca us relevant address details response holder
  PublishSubject<Resource<bool>> _fatcaUSRelevantW9AddressDetailsResponse =
      PublishSubject();

  ///fatca us relevant address details stream
  Stream<Resource<bool>> get fatcaUSRelevantW9AddressDetailsStream =>
      _fatcaUSRelevantW9AddressDetailsResponse.stream;

  ///all field validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all field validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  ///cupertino switch value subject
  final BehaviorSubject<bool> _additionalRequesterSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get additionalRequesterStream =>
      _additionalRequesterSubject.stream;

  void updateSwitchValue(bool value) {
    _additionalRequesterSubject.safeAdd(value);
  }

  bool isValid() {
    bool valid = false;
    if (_additionalRequesterSubject.value) {
      if (addressController.text.isNotEmpty &&
          stateController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          postCodeController.text.isNotEmpty &&
          exemptFromFatcaReportingController.text.isNotEmpty &&
          additionalRequesterNameController.text.isNotEmpty &&
          additionalRequesterAddressController.text.isNotEmpty &&
          additionalRequesterStateController.text.isNotEmpty &&
          additionalRequesterCityController.text.isNotEmpty &&
          additionalRequesterPostCodeController.text.isNotEmpty) {
        valid = true;
      }
    } else if (addressController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        postCodeController.text.isNotEmpty &&
        exemptFromFatcaReportingController.text.isNotEmpty) {
      valid = true;
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  FatcaUSRelevantW9AddressDetailsPageViewModel(
      this._fatcaUSRelevantW9AddressDetailsUseCase,
      this._getStateListUseCase,
      this._getCityListUseCase) {
    _fatcaUSRelevantW9AddressDetailsRequest.listen((value) {
      RequestManager(value,
          createCall: () => _fatcaUSRelevantW9AddressDetailsUseCase.execute(
              params: value)).asFlow().listen((event) {
        updateLoader();
        _fatcaUSRelevantW9AddressDetailsResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _getStateListRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getStateListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getStateListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getCityListRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getCityListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getCityListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void getStateList(String isoCode) {
    _getStateListRequest.safeAdd(GetStateListUseParams(isoCode: isoCode));
  }

  void getCityList(String isoCode, String stateId) {
    _getCityListRequest
        .safeAdd(GetCityListUseParams(isoCode: isoCode, stateID: stateId));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_ADDRESS:
        addressKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_STATE:
        stateKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_CITY:
        cityKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_POSTCODE:
        postCodeKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EXEMPTION_FATCA_CODE:
        exemptFromFatcaReportingKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_REQUESTER_NAME:
        additionalRequesterNameKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_REQUESTER_ADDRESS:
        additionalRequesterAddressNameKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_REQUESTER_STATE:
        additionalRequesterStateKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_REQUESTER_CITY:
        additionalRequesterCityKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_REQUESTER_POSTCODE:
        additionalRequesterPostCodeKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void validateFatcaUSRelevantW9AddressDetails() {
    _fatcaUSRelevantW9AddressDetailsRequest.safeAdd(
        FatcaUSRelevantW9AddressDetailsUseCaseParams(
            address: addressController.text,
            state: stateController.text,
            city: cityController.text,
            postCode: postCodeController.text,
            accountNumber: accountNumberController.text,
            exemptPayeeCode: exemptPayeeCodeNumberController.text,
            isAdditionalRequester: _additionalRequesterSubject.value,
            additionalRequesterName: additionalRequesterNameController.text,
            additionalRequesterAddress:
                additionalRequesterAddressController.text,
            additionalRequesterCity: additionalRequesterCityController.text,
            additionalRequesterPostCode:
                additionalRequesterPostCodeController.text,
            additionalRequesterState: additionalRequesterStateController.text,
            exemptFromFatcaReportingCode:
                exemptFromFatcaReportingController.text));
  }

  ///update data to main page
  void updateData(BuildContext context) {
    FatcaW9Data fatcaSetData = ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .getFatcaW9Data;
    fatcaSetData.usAddress = addressController.text;
    fatcaSetData.state = selectedAddressInUS.stateId;
    fatcaSetData.city = selectedAddressInUS.cityId;
    fatcaSetData.postCode = postCodeController.text;
    fatcaSetData.accountNumberList = accountNumberController.text;
    fatcaSetData.exemptPayeeCode = exemptPayeeCodeNumberController.text;
    fatcaSetData.exemptFromFatcaReportingCode =
        exemptFromFatcaReportingController.text;

    ///addition requester
    fatcaSetData.additionalRequester = _additionalRequesterSubject.value;
    fatcaSetData.requesterName = additionalRequesterNameController.text;
    fatcaSetData.requesterUsAddress = additionalRequesterAddressController.text;
    fatcaSetData.requesterState = selectedAdditionalRequester.stateId;
    fatcaSetData.requesterCity = selectedAdditionalRequester.cityId;
    fatcaSetData.requesterPostCode = additionalRequesterPostCodeController.text;
    ProviderScope.containerOf(context)
        .read(registerStepFourViewModelProvider)
        .setFatcaW9(fatcaSetData);
  }

  @override
  void dispose() {
    _fatcaUSRelevantW9AddressDetailsRequest.close();
    _fatcaUSRelevantW9AddressDetailsResponse.close();
    _allFieldValidatorSubject.close();
    _additionalRequesterSubject.close();
    super.dispose();
  }
}
