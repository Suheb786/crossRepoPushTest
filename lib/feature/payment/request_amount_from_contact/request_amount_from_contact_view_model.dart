import 'package:domain/usecase/payment/request_amount_from_contact_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class RequestAmountFromContactViewModel extends BasePageViewModel {
  RequestAmountFromContactUseCase _useCase;

  RequestAmountFromContactViewModel(this._useCase);
}
