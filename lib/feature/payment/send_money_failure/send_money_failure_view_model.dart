import 'package:domain/usecase/payment/send_money_failure_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_page.dart';

class SendMoneyFailureViewModel extends BasePageViewModel {
  SendMoneyFailureUseCase _useCase;
  final SendMoneyFailurePageArgument sendMoneyFailurePageArgument;
  SendMoneyFailureViewModel(this._useCase, this.sendMoneyFailurePageArgument);
}
