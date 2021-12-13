import 'package:domain/usecase/payment/send_money_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class SendMoneyViewModel extends BasePageViewModel {
  SendMoneyUseCase _useCase;

  SendMoneyViewModel(this._useCase);
}
