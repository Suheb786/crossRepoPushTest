import 'package:domain/usecase/dashboard/card_transaction_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class CardTransactionViewModel extends BasePageViewModel {
  CardTransactionUseCase _useCase;

  CardTransactionViewModel(this._useCase);
}
