import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/usecase/card_delivery/confirm_credit_card_delivery_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardDeliveredViewModel extends BasePageViewModel {
  final CreditCard creditCard;
  final ConfirmCreditCardDeliveryUseCase _confirmCreditDeliveryUsecase;

  ///confirm credit card delivery request
  PublishSubject<ConfirmCreditCardDeliveryUseCaseParams>
      _confirmCreditCardDeliveryRequest = PublishSubject();

  ///confirm credit card delivery response
  PublishSubject<Resource<bool>> _confirmCreditCardDeliveryResponse =
      PublishSubject();

  ///confirm credit card delivery response stream
  Stream<Resource<bool>> get confirmCreditCardDeliveryStream =>
      _confirmCreditCardDeliveryResponse.stream;

  CreditCardDeliveredViewModel(
      this._confirmCreditDeliveryUsecase, this.creditCard) {
    _confirmCreditCardDeliveryRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _confirmCreditDeliveryUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _confirmCreditCardDeliveryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void confirmCreditCardDelivery() {
    _confirmCreditCardDeliveryRequest
        .safeAdd(ConfirmCreditCardDeliveryUseCaseParams());
  }
}
