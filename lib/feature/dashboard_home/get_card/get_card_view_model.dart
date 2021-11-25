import 'package:domain/usecase/dashboard/get_card_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class GetCardViewModel extends BasePageViewModel {
  GetCardUseCase _useCase;

  GetCardViewModel(this._useCase);
}
