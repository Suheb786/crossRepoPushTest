import 'package:domain/usecase/payment/request_money_from_contact_success_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class RequestAmountFromContactSuccessViewModel extends BasePageViewModel {
  RequestAmountFromContactSuccessUseCase _useCase;

  RequestAmountFromContactSuccessViewModel(this._useCase);
}
