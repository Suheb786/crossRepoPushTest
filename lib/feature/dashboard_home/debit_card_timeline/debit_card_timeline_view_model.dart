import 'package:domain/usecase/dashboard/debit_card_timeline_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class DebitCardTimeLineViewModel extends BasePageViewModel {
  DebitCardTimeLineUseCase _useCase;

  DebitCardTimeLineViewModel(this._useCase);
}
