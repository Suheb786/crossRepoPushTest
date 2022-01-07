import 'package:domain/usecase/credit_card_application_failure/credit_card_application_failure_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class CreditCardApplicationFailureViewModel extends BasePageViewModel {
  CreditCardApplicationFailureUseCase _creditCardApplicationFailureUseCase;

  CreditCardApplicationFailureViewModel(
      this._creditCardApplicationFailureUseCase);
}
