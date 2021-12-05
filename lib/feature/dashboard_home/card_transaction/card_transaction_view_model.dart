import 'package:domain/usecase/dashboard/card_transaction_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class CardTransactionViewModel extends BasePageViewModel {
  CardTransactionUseCase _useCase;
  TextEditingController searchController = TextEditingController();

  CardTransactionViewModel(this._useCase);
}
