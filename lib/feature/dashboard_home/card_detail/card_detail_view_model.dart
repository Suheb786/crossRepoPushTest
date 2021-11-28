import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/dashboard/card_detail_usecase.dart';

class CardDetailViewModel extends BasePageViewModel {
  CardDetailUseCase _useCase;

  CardDetailViewModel(this._useCase);
}
