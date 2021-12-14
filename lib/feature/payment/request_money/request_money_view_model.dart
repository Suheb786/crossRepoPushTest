import 'package:domain/usecase/payment/request_money_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class RequestMoneyViewModel extends BasePageViewModel {
  RequestMoneyUseCase _useCase;

  RequestMoneyViewModel(this._useCase);
}
