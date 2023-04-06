import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page.dart';

class CreditConfirmationPaymentActivityViewModel extends BasePageViewModel {
  final CreditConfirmationArgument creditConfirmationArgument;

  CreditConfirmationPaymentActivityViewModel(this.creditConfirmationArgument);
}
