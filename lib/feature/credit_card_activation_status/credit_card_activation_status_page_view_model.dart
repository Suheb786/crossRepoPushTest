import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/usecase/card_delivery/credit_card_request_usecase.dart';
import 'package:domain/usecase/card_delivery/get_card_application_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardActivationStatusPageViewModel extends BasePageViewModel {
  final GetCardApplicationUseCase _getCardApplicationUseCase;

  final CreditCardRequestUseCase _creditCardRequestUseCase;

  ///get application request
  PublishSubject<GetCardApplicationUseCaseParams> _getApplicationRequest =
      PublishSubject();

  ///get application response
  PublishSubject<Resource<GetCardApplicationResponse>> _getApplicationResponse =
      PublishSubject();

  ///get application response stream
  Stream<Resource<GetCardApplicationResponse>>
      get getApplicationResponseStream => _getApplicationResponse.stream;

  ///credit card request
  PublishSubject<CreditCardRequestUseCaseParams> _creditCardReqRequest =
      PublishSubject();

  ///credit card response
  PublishSubject<Resource<bool>> _creditCardReqResponse = PublishSubject();

  ///credit card response stream
  Stream<Resource<bool>> get creditCardReqResponseStream =>
      _creditCardReqResponse.stream;

  CreditCardActivationStatusPageViewModel(
      this._getCardApplicationUseCase, this._creditCardRequestUseCase) {
    _getApplicationRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getCardApplicationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getApplicationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _creditCardReqRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _creditCardRequestUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _creditCardReqResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    getApplication();
  }

  void getApplication() {
    _getApplicationRequest.safeAdd(GetCardApplicationUseCaseParams());
  }

  void creditCardRequest(String cardId) {
    _creditCardReqRequest
        .safeAdd(CreditCardRequestUseCaseParams(cardId: cardId));
  }

  @override
  void dispose() {
    _getApplicationRequest.close();
    _getApplicationResponse.close();
    super.dispose();
  }
}
