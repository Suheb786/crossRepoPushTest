import 'package:domain/usecase/payment/send_money_failure_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class SendMoneyFailureViewModel extends BasePageViewModel {
  SendMoneyFailureUseCase _useCase;

  SendMoneyFailureViewModel(this._useCase);
}
