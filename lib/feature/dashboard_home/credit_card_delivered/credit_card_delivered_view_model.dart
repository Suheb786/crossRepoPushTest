import 'package:domain/usecase/dashboard/credit_card_delivered_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class CreditCardDeliveredViewModel extends BasePageViewModel {
  CreditCardDeliveredUseCase _useCase;

  CreditCardDeliveredViewModel(this._useCase);
}
