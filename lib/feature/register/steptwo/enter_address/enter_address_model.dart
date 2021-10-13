import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/user/enter_address_usecase.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class EnterAddressViewModel extends BasePageViewModel {
  final EnterAddressUseCase _enterAddressUseCase;
  TextEditingController residentCountryController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController buildingNameOrNumberController = TextEditingController();

  bool? dropDownEnabled = true;

  final GlobalKey<AppTextFieldState> residentCountryKey =
  GlobalKey(debugLabel: "residentCountry");

  final GlobalKey<AppTextFieldState> homeAddressrKey =
  GlobalKey(debugLabel: "homeAddress");

  final GlobalKey<AppTextFieldState> streetAddressKey =
  GlobalKey(debugLabel: "streetAddress");

  final GlobalKey<AppTextFieldState> buildingNameOrNumberKey =
  GlobalKey(debugLabel: "buildingNameOrNumber");

  /// enter address request subject holder
  PublishSubject<EnterAddressUseCaseParams> _enterAddressRequest =
  PublishSubject();

  /// enter address response subject holder
  // ignore: close_sinks
  PublishSubject<Resource<bool>> _enterAddressResponse = PublishSubject();

  Stream<Resource<bool>> get enterAddressResponseStream => _enterAddressResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///error detector subject holder
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

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
        buildingNameOrNo: buildingNameOrNumberController.text,));
  }

  void validateAddress() {
    if (residentCountryController.text.isNotEmpty &&
        homeAddressController.text.isNotEmpty&&
        streetAddressController.text.isNotEmpty&&
        buildingNameOrNumberController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 800), () {
      _errorDetectorSubject.safeAdd(false);
    });
  }
}