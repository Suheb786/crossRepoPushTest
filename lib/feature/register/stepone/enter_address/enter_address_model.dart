import 'package:domain/usecase/user/enter_address_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EnterAddressViewModel extends BasePageViewModel {
  final EnterAddressUseCase _enterAddressUseCase;
  TextEditingController residentCountryController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController buildingNameOrNumberController =
      TextEditingController();
  TextEditingController permanentHomeAddressController =
      TextEditingController();
  TextEditingController permanentStreetAddressController =
      TextEditingController();
  TextEditingController permanentBuildingNameOrNumberController =
      TextEditingController();
  TextEditingController permanentResidentCountryController =
      TextEditingController();
  TextEditingController permanentCityController = TextEditingController();

  bool? dropDownEnabled = true;

  final GlobalKey<AppTextFieldState> residentCountryKey =
      GlobalKey(debugLabel: "residentCountry");

  final GlobalKey<AppTextFieldState> homeAddressrKey =
      GlobalKey(debugLabel: "homeAddress");

  final GlobalKey<AppTextFieldState> streetAddressKey =
      GlobalKey(debugLabel: "streetAddress");

  final GlobalKey<AppTextFieldState> buildingNameOrNumberKey =
      GlobalKey(debugLabel: "buildingNameOrNumber");

  final GlobalKey<AppTextFieldState> permanentHomeAddressKey =
      GlobalKey(debugLabel: "permanentHomeAddress");

  final GlobalKey<AppTextFieldState> permanentStreetAddressKey =
      GlobalKey(debugLabel: "permanentStreetAddress");

  final GlobalKey<AppTextFieldState> permanentBuildingNameOrNumberKey =
      GlobalKey(debugLabel: "permanentBuildingNameOrNumber");

  final GlobalKey<AppTextFieldState> permanentResidentCountryKey =
      GlobalKey(debugLabel: "permanentResidentCountry");

  final GlobalKey<AppTextFieldState> permanentCityKey =
      GlobalKey(debugLabel: "permanentCity");

  /// enter address request subject holder
  PublishSubject<EnterAddressUseCaseParams> _enterAddressRequest =
      PublishSubject();

  /// enter address response subject holder
  PublishSubject<Resource<bool>> _enterAddressResponse = PublishSubject();

  Stream<Resource<bool>> get enterAddressResponseStream =>
      _enterAddressResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///permanent address Subject holder
  BehaviorSubject<bool> _permanentAddressVisibilitySubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get permanentAddressVisibilityStream =>
      _permanentAddressVisibilitySubject.stream;

  void updatePermanentAddressVisibility() {
    if (residentCountryController.text == 'Jordan') {
      _permanentAddressVisibilitySubject.safeAdd(false);
    } else {
      _permanentAddressVisibilitySubject.safeAdd(true);
    }
  }

  EnterAddressViewModel(this._enterAddressUseCase) {
    _enterAddressRequest.listen((value) {
      RequestManager(value,
              createCall: () => _enterAddressUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _enterAddressResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void enterAddress() {
    _enterAddressRequest.safeAdd(EnterAddressUseCaseParams(
        residentCountry: residentCountryController.text,
        homeAddress: homeAddressController.text,
        streetAddress: streetAddressController.text,
        buildingNameOrNo: buildingNameOrNumberController.text,
        jordanianLivesAbroad: _permanentAddressVisibilitySubject.value,
        permanentCity: permanentCityController.text,
        permanentResidentCountry: permanentResidentCountryController.text));
  }

  void validateAddress() {
    bool isValid = false;
    if (_permanentAddressVisibilitySubject.value) {
      if (residentCountryController.text.isNotEmpty &&
          homeAddressController.text.isNotEmpty &&
          streetAddressController.text.isNotEmpty &&
          buildingNameOrNumberController.text.isNotEmpty &&
          permanentResidentCountryController.text.isNotEmpty &&
          permanentCityController.text.isNotEmpty) {
        isValid = true;
      }
    } else if (residentCountryController.text.isNotEmpty &&
        homeAddressController.text.isNotEmpty &&
        streetAddressController.text.isNotEmpty &&
        buildingNameOrNumberController.text.isNotEmpty) {
      isValid = true;
    }
    _showButtonSubject.safeAdd(isValid);
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _enterAddressRequest.close();
    _enterAddressResponse.close();
    _permanentAddressVisibilitySubject.close();
    super.dispose();
  }
}
