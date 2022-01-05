import 'package:domain/usecase/apply_credit_card/set_credit_limit_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class SetCreditLimitViewModel extends BasePageViewModel {
  SetCreditLimitUseCase _setCreditLimitUseCase;

  List<String> percentageList = [
    "3 %",
    "5 %",
    "7 %",
    "10 %",
    "12 %",
  ];

  TextEditingController minimumSettlementController = TextEditingController();

  SetCreditLimitViewModel(this._setCreditLimitUseCase);
}
