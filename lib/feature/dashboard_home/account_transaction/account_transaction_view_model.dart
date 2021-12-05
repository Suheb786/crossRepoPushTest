import 'package:domain/usecase/dashboard/account_transaction_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class AccountTransactionViewModel extends BasePageViewModel {
  AccountTransactionUseCase _useCase;
  TextEditingController searchController = TextEditingController();

  AccountTransactionViewModel(this._useCase);
}
