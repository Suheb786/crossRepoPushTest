import 'package:domain/usecase/payment/add_request_money_contact_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class AddRequestMoneyContactViewModel extends BasePageViewModel {
  AddRequestMoneyContactUseCase _useCase;

  AddRequestMoneyContactViewModel(this._useCase);
}
