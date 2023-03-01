import 'package:domain/usecase/dashboard/my_account_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class MyAccountViewModel extends BasePageViewModel {
  MyAccountUseCase _useCase;

  MyAccountViewModel(this._useCase);

  Size deviceSize = Size(0, 0);
}
