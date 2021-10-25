import 'package:domain/usecase/user/account_ready_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class AccountReadyViewModel extends BasePageViewModel {
  final AccountReadyUseCase _accountReadyUseCase;

  AccountReadyViewModel(this._accountReadyUseCase);
}
