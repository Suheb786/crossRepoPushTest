import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/user/confirm_detail_usecase.dart';

class ConfirmDetailViewModel extends BasePageViewModel {
  final ConfirmDetailUseCase _confirmDetailUseCase;
  TextEditingController nameController = new TextEditingController();
  TextEditingController idNumberController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController nationalityController = new TextEditingController();
  TextEditingController expiryDateController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  bool? _open = true;

  bool? get open=>_open;

  changeOpen(bool value) {
    _open = value;
  }

  ConfirmDetailViewModel(this._confirmDetailUseCase);
}