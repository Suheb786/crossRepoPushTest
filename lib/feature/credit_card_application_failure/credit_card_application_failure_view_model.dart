import 'package:domain/usecase/credit_card_application_failure/credit_card_application_failure_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page.dart';

class CreditCardApplicationFailureViewModel extends BasePageViewModel {
  CreditCardApplicationFailureUseCase _creditCardApplicationFailureUseCase;
  final CreditCardApplicationFailureArguments creditCardApplicationFailureArguments;

  CreditCardApplicationFailureViewModel(
      this._creditCardApplicationFailureUseCase, this.creditCardApplicationFailureArguments);
}
