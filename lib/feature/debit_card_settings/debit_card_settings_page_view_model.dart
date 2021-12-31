import 'package:domain/usecase/card_delivery/cancel_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/freeze_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/unfreeze_debit_card_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DebitCardSettingsPageViewModel extends BasePageViewModel {
  final FreezeDebitCardUseCase _freezeDebitCardUseCase;
  final UnFreezeDebitCardUseCase _unFreezeDebitCardUseCase;
  final CancelDebitCardUseCase _cancelDebitCardUseCase;
  PublishSubject<bool> _freezeCardSubject = PublishSubject();

  PublishSubject<Resource<bool>> _freezeCardResponseSubject = PublishSubject();

  PublishSubject<FreezeDebitCardUseCaseParams> _freezeCardRequestSubject =
      PublishSubject();

  PublishSubject<UnFreezeDebitCardUseCaseParams> _unFreezeCardRequestSubject =
      PublishSubject();

  PublishSubject<Resource<bool>> _cancelCardResponseSubject = PublishSubject();

  PublishSubject<CancelDebitCardUseCaseParams> _cancelCardRequestSubject =
      PublishSubject();

  DebitCardSettingsPageViewModel(this._freezeDebitCardUseCase,
      this._unFreezeDebitCardUseCase, this._cancelDebitCardUseCase) {
    _freezeCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _freezeDebitCardUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();

        _freezeCardResponseSubject.safeAdd(event);

        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);

          _freezeCardSubject.safeAdd(false);
        }

        if (event.status == Status.SUCCESS) {
          _freezeCardSubject.safeAdd(true);
        }
      });
    });

    _unFreezeCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _unFreezeDebitCardUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();

        _freezeCardResponseSubject.safeAdd(event);

        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);

          _freezeCardSubject.safeAdd(true);
        }

        if (event.status == Status.SUCCESS) {
          _freezeCardSubject.safeAdd(false);
        }
      });
    });

    _cancelCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _cancelDebitCardUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();

        _cancelCardResponseSubject.safeAdd(event);

        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }

        if (event.status == Status.SUCCESS) {}
      });
    });
  }

  Stream<bool> get freezeCardStream => _freezeCardSubject.stream;

  Stream<Resource<bool>> get freezeCardResponseStream =>
      _freezeCardResponseSubject.stream;

  Stream<Resource<bool>> get cancelCardResponseStream =>
      _cancelCardResponseSubject.stream;

  void toggleFreezeCardStatus(bool value) {
    _freezeCardSubject.safeAdd(value);

    if (!value) {
      unFreezeCard();
    }
  }

  @override
  void dispose() {
    _freezeCardSubject.close();

    _freezeCardResponseSubject.close();

    _freezeCardRequestSubject.close();

    _unFreezeCardRequestSubject.close();

    _cancelCardRequestSubject.close();

    _cancelCardResponseSubject.close();

    super.dispose();
  }

  void freezeCard() {
    _freezeCardRequestSubject.safeAdd(FreezeDebitCardUseCaseParams());
  }

  void unFreezeCard() {
    _unFreezeCardRequestSubject.safeAdd(UnFreezeDebitCardUseCaseParams());
  }

  void cancelCard(String reasonValue) {
    _cancelCardRequestSubject
        .safeAdd(CancelDebitCardUseCaseParams(status: reasonValue));
  }
}
