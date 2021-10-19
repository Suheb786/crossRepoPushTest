import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w8_address_details_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class FatcaUSRelevantW8AddressDetailsPageViewModel extends BasePageViewModel {
  final FatcaUSRelevantW8AddressDetailsUseCase
      _fatcaUSRelevantW8AddressDetailsUseCase;

  ///controllers and keys
  final TextEditingController permanentAddressController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> permanentAddressKey =
      GlobalKey(debugLabel: "permanentAddress");

  final TextEditingController countryController = TextEditingController();
  final GlobalKey<AppTextFieldState> countryKey =
      GlobalKey(debugLabel: "country");

  final TextEditingController stateController = TextEditingController();
  final GlobalKey<AppTextFieldState> stateKey = GlobalKey(debugLabel: "state");

  final TextEditingController cityController = TextEditingController();
  final GlobalKey<AppTextFieldState> cityKey = GlobalKey(debugLabel: "city");

  final TextEditingController postCodeController = TextEditingController();
  final GlobalKey<AppTextFieldState> postCodeKey =
      GlobalKey(debugLabel: "postCode");

  ///fatca us relevant address details request subject holder
  PublishSubject<FatcaUSRelevantW8AddressDetailsUseCaseParams>
      _fatcaUSRelevantW8AddressDetailsRequest = PublishSubject();

  ///fatca us relevant address details response holder
  PublishSubject<Resource<bool>> _fatcaUSRelevantW8AddressDetailsResponse =
      PublishSubject();

  ///fatca us relevant address details stream
  Stream<Resource<bool>> get fatcaUSRelevantW8AddressDetailsStream =>
      _fatcaUSRelevantW8AddressDetailsResponse.stream;

  ///all field validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all field validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  ///cupertino switch value subject
  final BehaviorSubject<bool> _mailingAddressDifferentSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get mailingAddressDifferentStream =>
      _mailingAddressDifferentSubject.stream;

  void updateSwitchValue(bool value) {
    _mailingAddressDifferentSubject.safeAdd(value);
  }

  bool isValid() {
    bool valid = false;
    if (permanentAddressController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        postCodeController.text.isNotEmpty) {
      valid = true;
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  FatcaUSRelevantW8AddressDetailsPageViewModel(
      this._fatcaUSRelevantW8AddressDetailsUseCase) {
    _fatcaUSRelevantW8AddressDetailsRequest.listen((value) {
      RequestManager(value,
          createCall: () => _fatcaUSRelevantW8AddressDetailsUseCase.execute(
              params: value)).asFlow().listen((event) {
        _fatcaUSRelevantW8AddressDetailsResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_PERMANENT_ADDRESS_LINE:
        permanentAddressKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_COUNTRY:
        countryKey.currentState!.isValid = false;
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
    }
  }

  void validateFatcaUSRelevantW8AddressDetails() {
    _fatcaUSRelevantW8AddressDetailsRequest.safeAdd(
        FatcaUSRelevantW8AddressDetailsUseCaseParams(
            permanentAddress: permanentAddressController.text,
            state: stateController.text,
            country: countryController.text,
            city: cityController.text,
            postCode: postCodeController.text));
  }

  @override
  void dispose() {
    _fatcaUSRelevantW8AddressDetailsRequest.close();
    _fatcaUSRelevantW8AddressDetailsResponse.close();
    _allFieldValidatorSubject.close();
    super.dispose();
  }
}
