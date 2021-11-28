import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/dashboard/card_delivered_usecase.dart';

class CardDeliveredViewModel extends BasePageViewModel {
  CardDeliveredUseCase _useCase;

  CardDeliveredViewModel(this._useCase);
}
