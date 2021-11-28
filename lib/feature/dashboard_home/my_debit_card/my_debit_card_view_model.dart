import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/dashboard/my_debit_card_usecase.dart';

class MyDebitCardViewModel extends BasePageViewModel {
  MyDebitCardUseCase _useCase;

  MyDebitCardViewModel(this._useCase);
}
