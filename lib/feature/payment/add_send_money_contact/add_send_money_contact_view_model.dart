import 'package:domain/usecase/payment/add_send_money_contact_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class AddSendMoneyContactViewModel extends BasePageViewModel {
  AddSendMoneyContactUseCase _useCase;

  AddSendMoneyContactViewModel(this._useCase);
}
