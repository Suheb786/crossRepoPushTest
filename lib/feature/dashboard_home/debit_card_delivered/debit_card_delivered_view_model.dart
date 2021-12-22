import 'package:domain/usecase/dashboard/debit_card_delivered_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';

class DebitCardDeliveredViewModel extends BasePageViewModel {
  final DebitCard debitCard;
  DebitCardDeliveredUseCase _useCase;

  DebitCardDeliveredViewModel(this._useCase, this.debitCard);
}
