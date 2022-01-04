import 'package:domain/model/payment/transfer_success_content.dart';
import 'package:domain/usecase/payment/send_amount_to_contact_success_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class SendAmountToContactSuccessViewModel extends BasePageViewModel {
  final TransferSuccessContent arguments;
  SendAmountToContactSuccessUseCase _useCase;

  SendAmountToContactSuccessViewModel(this._useCase, this.arguments);
}
