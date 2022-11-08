import 'package:domain/usecase/dashboard/debit_card_verification_success_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class DebitCardVerificationSuccessViewModel extends BasePageViewModel {
  DebitCardVerificationSuccessUseCase _useCase;

  DebitCardVerificationSuccessViewModel(this._useCase);
}
