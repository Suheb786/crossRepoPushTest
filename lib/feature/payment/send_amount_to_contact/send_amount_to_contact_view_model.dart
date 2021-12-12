import 'package:domain/usecase/payment/send_amount_to_contact_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class SendAmountToContactViewModel extends BasePageViewModel {
  SendAmountToContactUseCase _useCase;

  SendAmountToContactViewModel(this._useCase);
}
