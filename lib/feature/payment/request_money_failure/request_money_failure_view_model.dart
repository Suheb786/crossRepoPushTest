import 'package:domain/usecase/payment/request_money_failure_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class RequestMoneyFailureViewModel extends BasePageViewModel {
  RequestMoneyFailureUseCase _useCase;

  RequestMoneyFailureViewModel(this._useCase);
}
