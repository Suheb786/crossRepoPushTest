import 'package:domain/model/payment/transfer_success_content.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class SendAmountToContactSuccessViewModel extends BasePageViewModel {
  final TransferSuccessContent arguments;

  SendAmountToContactSuccessViewModel(this.arguments);
}
