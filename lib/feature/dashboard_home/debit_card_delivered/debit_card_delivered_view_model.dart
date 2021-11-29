import 'package:domain/usecase/dashboard/debit_card_delivered_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class DebitCardDeliveredViewModel extends BasePageViewModel {
  DebitCardDeliveredUseCase _useCase;

  DebitCardDeliveredViewModel(this._useCase);
}
