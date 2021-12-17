import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/dashboard/my_account_usecase.dart';

class MyAccountViewModel extends BasePageViewModel {
  MyAccountUseCase _useCase;

  MyAccountViewModel(this._useCase);
}
