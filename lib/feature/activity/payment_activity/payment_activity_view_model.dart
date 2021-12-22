import 'package:domain/usecase/activity/payment_activity_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class PaymentActivityViewModel extends BasePageViewModel {
  PaymentActivityUseCase _useCase;

  PaymentActivityViewModel(this._useCase);
}
