import 'package:domain/usecase/card_delivery/cancel_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/freeze_credit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/unfreeze_credit_card_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardSettingsViewModel extends BasePageViewModel {
  final FreezeCreditCardUseCase _freezeCreditCardUseCase;
  final UnFreezeCreditCardUseCase _unFreezeCreditCardUseCase;
  final CancelCreditCardUseCase _cancelCreditCardUseCase;

  PublishSubject<bool> _toggleFreezeCardSubject = PublishSubject();

  Stream<bool> get freezeCardStream => _toggleFreezeCardSubject.stream;

  PublishSubject<FreezeCreditCardUseCaseParams> _freezeCardRequestSubject =
      PublishSubject();
  PublishSubject<Resource<bool>> _toggleFreezeCardSubjectResponse =
      PublishSubject();

  Stream<Resource<bool>> get toggleFreezeCardStream =>
      _toggleFreezeCardSubjectResponse.stream;

  PublishSubject<UnFreezeCreditCardUseCaseParams> _unFreezeCardRequestSubject =
      PublishSubject();

  PublishSubject<CancelCreditCardUseCaseParams>
      _cancelCreditCardRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _cancelCreditCardResponseSubject =
      PublishSubject();

  Stream<Resource<bool>> get cancelCreditCardStream =>
      _cancelCreditCardResponseSubject.stream;

  CreditCardSettingsViewModel(this._freezeCreditCardUseCase,
      this._unFreezeCreditCardUseCase, this._cancelCreditCardUseCase) {
    _freezeCardRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () => _freezeCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _toggleFreezeCardSubjectResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          _toggleFreezeCardSubject.safeAdd(false);
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          _toggleFreezeCardSubject.safeAdd(true);
        }
      });
    });

    _unFreezeCardRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _unFreezeCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _toggleFreezeCardSubjectResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          _toggleFreezeCardSubject.safeAdd(true);
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          _toggleFreezeCardSubject.safeAdd(false);
        }
      });
    });

    _cancelCreditCardRequestSubject.listen((value) {
      RequestManager(value,
              createCall: () => _cancelCreditCardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _cancelCreditCardResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void toggleFreezeCardStatus(bool value) {
    _toggleFreezeCardSubject.safeAdd(value);
    if (!value) {
      unFreezeCard();
    }
  }

  void freezeCard() {
    _freezeCardRequestSubject.safeAdd(FreezeCreditCardUseCaseParams());
  }

  void unFreezeCard() {
    _unFreezeCardRequestSubject.safeAdd(UnFreezeCreditCardUseCaseParams());
  }

  void cancelCard(String reason) {
    _cancelCreditCardRequestSubject
        .safeAdd(CancelCreditCardUseCaseParams(reason: reason));
  }

  @override
  void dispose() {
    _toggleFreezeCardSubject.close();
    _freezeCardRequestSubject.close();
    _unFreezeCardRequestSubject.close();
    _toggleFreezeCardSubjectResponse.close();
    _cancelCreditCardResponseSubject.close();
    super.dispose();
  }
}
