import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/usecase/blink_credit_card/blink_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/get_card_application_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class BlinkCreditCardViewModel extends BasePageViewModel {
  BlinkCreditCardUseCase _blinkCreditCardUseCase;
  final GetCardApplicationUseCase _applicationUseCase;

  BehaviorSubject<bool> _isCheckedSubject = BehaviorSubject.seeded(false);

  PublishSubject<BlinkCreditCardUseCaseParams> _blinkRequest = PublishSubject();

  Stream<bool> get isCheckedStream => _isCheckedSubject.stream;

  PublishSubject<Resource<bool>> _blinkResponse = PublishSubject();

  Stream<Resource<bool>> get blinkResponseStream => _blinkResponse.stream;

  ///get application request
  PublishSubject<GetCardApplicationUseCaseParams> _getApplicationRequest =
      PublishSubject();

  ///get application response
  PublishSubject<Resource<GetCardApplicationResponse>> _getApplicationResponse =
      PublishSubject();

  ///get application response stream
  Stream<Resource<GetCardApplicationResponse>>
      get getApplicationResponseStream => _getApplicationResponse.stream;

  BlinkCreditCardViewModel(
      this._blinkCreditCardUseCase, this._applicationUseCase) {
    _blinkRequest.listen((value) {
      RequestManager(value,
              createCall: () => _blinkCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _blinkResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getApplicationRequest.listen((value) {
      RequestManager(value,
              createCall: () => _applicationUseCase.execute(params: value))
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
  }

  updateCheckBox(bool value) {
    _isCheckedSubject.safeAdd(value);
  }

  void submit() {
    _blinkRequest.safeAdd(
        BlinkCreditCardUseCaseParams(isChecked: _isCheckedSubject.value));
  }

  void getApplication() {
    _getApplicationRequest.safeAdd(GetCardApplicationUseCaseParams());
  }

  @override
  void dispose() {
    _blinkResponse.close();
    _blinkRequest.close();
    _isCheckedSubject.close();
    super.dispose();
  }
}
