import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/user/enter_address_usecase.dart';

class EnterAddressViewModel extends BasePageViewModel {
  final EnterAddressUseCase _enterAddressUseCase;
  TextEditingController residentCountryController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController buildingNameOrNoController = TextEditingController();

  bool? dropDownEnabled = true;

  EnterAddressViewModel(this._enterAddressUseCase);
}