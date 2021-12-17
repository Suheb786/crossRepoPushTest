import 'package:domain/usecase/dashboard/credit_card_verification_success_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class CreditCardVerificationSuccessViewModel extends BasePageViewModel {
  CreditCardVerificationSuccessUseCase _useCase;

  CreditCardVerificationSuccessViewModel(this._useCase);
}
